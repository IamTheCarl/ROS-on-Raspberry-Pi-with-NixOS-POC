
from xdg.BaseDirectory import load_data_paths
import rclpy
from rclpy.node import Node
from piper_interface.srv import Speak 
import subprocess

class Piper(Node):
    def __init__(self):
        super().__init__('piper')
        self.speak_service = self.create_service(Speak, 'speak', self.speak)
        self.get_logger().info("Service started.")

    def speak(self, request, response):
        self.get_logger().info("Speak ({}): {}".format(request.voice_name, request.text))

        model_path = "voice_models/{}.onnx".format(request.voice_name)
        model_path = next(load_data_paths(model_path), None)

        if model_path is not None:
            # print('Voice model paths: {}'.format(model_path))
            process = subprocess.Popen(["piper", "-m", model_path, "--output_raw"],
                    stdin=subprocess.PIPE,
                    stdout=subprocess.PIPE)
            audio_data, _stderr = process.communicate(input=request.text.encode())

            if process.returncode == 0:
                # For the life of me I could not find a working Python audio library (I tried three)
                # so this jank is my solution.
                process = subprocess.Popen(["aplay", "-r", "22050", "-f", "S16_LE", "-t", "raw", "-"],
                        stdin=subprocess.PIPE)
                _, _ = process.communicate(input=audio_data)

                if process.returncode == 0:
                    response.result = Speak.Response.SUCCESS
                else:    
                    response.result = Speak.Response.PLAYBACK_FAILURE
            else:
                self.get_logger().error("Piper returned error code: {}".format(process.returncode))
                response.result = Speak.Response.AUDIO_GENERATION_FAILURE

        else:
            # Could not find the voice
            self.get_logger().error("Could not find voice \"{}\"".format(request.voice_name))
            response.result = Speak.Response.VOICE_NOT_FOUND

        return response


def main(args=None):
    rclpy.init(args=args)
    piper = Piper()
    rclpy.spin(piper)
    rclpy.shutdown()

if __name__ == '__main__':
    main()
