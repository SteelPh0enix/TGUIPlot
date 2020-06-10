cmake_minimum_required(VERSION 3.0)

project(TGUIPlot)

set(CMAKE_CXX_STANDARD 17)

OPTION(DEBUG_LOG "Set logging level to 'debug'" FALSE)
if(DEBUG_LOG)
  add_definitions(-DDEBUG_LOG)
endif()

find_package(SFML COMPONENTS system graphics window REQUIRED)
find_package(TGUI REQUIRED)
find_package(spdlog REQUIRED)

set(CXX_DEBUG_FLAGS "-Wall -Wextra -O0 -g")
set(CXX_RELEASE_FLAGS "-Wall -Wextra -O3")

if(CMAKE_BUILD_TYPE MATCHES Release)
  set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} ${CXX_RELEASE_FLAGS})
  if (WIN32)
    set(SFML_LIBS sfml-main sfml-system sfml-window sfml-graphics)
  else()
    set(SFML_LIBS sfml-system sfml-window sfml-graphics)
  endif()
  set(TGUI_LIBS tgui)
  set(SPDLOG_LIBS spdlog)
else()
  set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} ${CXX_DEBUG_FLAGS})
  set(SFML_LIBS sfml-system-d sfml-window-d sfml-graphics-d)
  set(TGUI_LIBS tgui-d)
  set(SPDLOG_LIBS spdlogd)
endif()

# THIS IS TEMPORARY SOLUTION - FINAL PROJECT SHOULD BE PROPERLY SPLITTED INTO MODULES AND ORGANIZED
include_directories("./include/")
file(GLOB SRC_FILES ./src/*.cpp)

add_executable(${PROJECT_NAME} main.cpp ${SRC_FILES})
target_link_libraries(${PROJECT_NAME} PRIVATE ${SFML_LIBS} ${TGUI_LIBS} ${SPDLOG_LIBS})