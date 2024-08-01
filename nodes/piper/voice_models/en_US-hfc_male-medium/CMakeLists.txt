cmake_minimum_required(VERSION 3.8)
project(en_US-hfc_male-medium)

find_package(ament_cmake REQUIRED)

install(DIRECTORY voice_models
  DESTINATION share/${PROJECT_NAME}
)

ament_package()
