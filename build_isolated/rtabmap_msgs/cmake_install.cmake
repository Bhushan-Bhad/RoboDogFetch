# Install script for directory: /home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/bunny/RoboDogFetch/install_isolated")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
        file(MAKE_DIRECTORY "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
      endif()
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin")
        file(WRITE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin" "")
      endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/bunny/RoboDogFetch/install_isolated/_setup_util.py")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/bunny/RoboDogFetch/install_isolated" TYPE PROGRAM FILES "/home/bunny/RoboDogFetch/build_isolated/rtabmap_msgs/catkin_generated/installspace/_setup_util.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/bunny/RoboDogFetch/install_isolated/env.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/bunny/RoboDogFetch/install_isolated" TYPE PROGRAM FILES "/home/bunny/RoboDogFetch/build_isolated/rtabmap_msgs/catkin_generated/installspace/env.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/bunny/RoboDogFetch/install_isolated/setup.bash;/home/bunny/RoboDogFetch/install_isolated/local_setup.bash")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/bunny/RoboDogFetch/install_isolated" TYPE FILE FILES
    "/home/bunny/RoboDogFetch/build_isolated/rtabmap_msgs/catkin_generated/installspace/setup.bash"
    "/home/bunny/RoboDogFetch/build_isolated/rtabmap_msgs/catkin_generated/installspace/local_setup.bash"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/bunny/RoboDogFetch/install_isolated/setup.sh;/home/bunny/RoboDogFetch/install_isolated/local_setup.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/bunny/RoboDogFetch/install_isolated" TYPE FILE FILES
    "/home/bunny/RoboDogFetch/build_isolated/rtabmap_msgs/catkin_generated/installspace/setup.sh"
    "/home/bunny/RoboDogFetch/build_isolated/rtabmap_msgs/catkin_generated/installspace/local_setup.sh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/bunny/RoboDogFetch/install_isolated/setup.zsh;/home/bunny/RoboDogFetch/install_isolated/local_setup.zsh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/bunny/RoboDogFetch/install_isolated" TYPE FILE FILES
    "/home/bunny/RoboDogFetch/build_isolated/rtabmap_msgs/catkin_generated/installspace/setup.zsh"
    "/home/bunny/RoboDogFetch/build_isolated/rtabmap_msgs/catkin_generated/installspace/local_setup.zsh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/bunny/RoboDogFetch/install_isolated/.rosinstall")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/bunny/RoboDogFetch/install_isolated" TYPE FILE FILES "/home/bunny/RoboDogFetch/build_isolated/rtabmap_msgs/catkin_generated/installspace/.rosinstall")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rtabmap_msgs/msg" TYPE FILE FILES
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/Info.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/KeyPoint.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/GlobalDescriptor.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/ScanDescriptor.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/MapData.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/MapGraph.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/Node.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/SensorData.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/Link.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/OdomInfo.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/LandmarkDetection.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/LandmarkDetections.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/Point2f.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/Point3f.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/Goal.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/RGBDImage.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/RGBDImages.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/UserData.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/GPS.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/Path.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/EnvSensor.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/CameraModel.msg"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/msg/CameraModels.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rtabmap_msgs/srv" TYPE FILE FILES
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/srv/GetMap.srv"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/srv/GetMap2.srv"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/srv/ListLabels.srv"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/srv/PublishMap.srv"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/srv/ResetPose.srv"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/srv/SetGoal.srv"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/srv/SetLabel.srv"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/srv/RemoveLabel.srv"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/srv/GetPlan.srv"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/srv/AddLink.srv"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/srv/GetNodeData.srv"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/srv/GetNodesInRadius.srv"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/srv/LoadDatabase.srv"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/srv/DetectMoreLoopClosures.srv"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/srv/GlobalBundleAdjustment.srv"
    "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/srv/CleanupLocalGrids.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rtabmap_msgs/cmake" TYPE FILE FILES "/home/bunny/RoboDogFetch/build_isolated/rtabmap_msgs/catkin_generated/installspace/rtabmap_msgs-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/bunny/RoboDogFetch/devel_isolated/rtabmap_msgs/include/rtabmap_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/bunny/RoboDogFetch/devel_isolated/rtabmap_msgs/share/roseus/ros/rtabmap_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/bunny/RoboDogFetch/devel_isolated/rtabmap_msgs/share/common-lisp/ros/rtabmap_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/bunny/RoboDogFetch/devel_isolated/rtabmap_msgs/share/gennodejs/ros/rtabmap_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/bunny/RoboDogFetch/devel_isolated/rtabmap_msgs/lib/python3/dist-packages/rtabmap_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/bunny/RoboDogFetch/devel_isolated/rtabmap_msgs/lib/python3/dist-packages/rtabmap_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/bunny/RoboDogFetch/build_isolated/rtabmap_msgs/catkin_generated/installspace/rtabmap_msgs.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rtabmap_msgs/cmake" TYPE FILE FILES "/home/bunny/RoboDogFetch/build_isolated/rtabmap_msgs/catkin_generated/installspace/rtabmap_msgs-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rtabmap_msgs/cmake" TYPE FILE FILES
    "/home/bunny/RoboDogFetch/build_isolated/rtabmap_msgs/catkin_generated/installspace/rtabmap_msgsConfig.cmake"
    "/home/bunny/RoboDogFetch/build_isolated/rtabmap_msgs/catkin_generated/installspace/rtabmap_msgsConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/rtabmap_msgs" TYPE FILE FILES "/home/bunny/RoboDogFetch/src/rtabmap_ros/rtabmap_msgs/package.xml")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/bunny/RoboDogFetch/build_isolated/rtabmap_msgs/gtest/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/bunny/RoboDogFetch/build_isolated/rtabmap_msgs/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
