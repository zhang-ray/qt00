cmake_minimum_required(VERSION 3.5)

project(qt00 LANGUAGES CXX)



if(WIN32)
    set(CMAKE_PREFIX_PATH "C:/Qt/5.11/msvc2015")
else(WIN32)
    if(APPLE AND EXISTS /usr/local/opt/qt5)
        # ensure it can be found by CMake since it is not in the default /usr/local prefix.
        list(APPEND CMAKE_PREFIX_PATH "/usr/local/opt/qt5")
    else()
        list(APPEND CMAKE_PREFIX_PATH "/usr/include/x86_64-linux-gnu/qt5")
        INCLUDE_DIRECTORIES("/usr/include/x86_64-linux-gnu/qt5")
        add_definitions(-D LINUX_CLIENT)
        add_compile_options(-fPIC)
    endif()
endif(WIN32)


set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt5 COMPONENTS Widgets REQUIRED)

add_executable(qt00
  main.cpp
  mainwindow.cpp
  mainwindow.h
  mainwindow.ui
)

target_link_libraries(qt00 PRIVATE Qt5::Widgets)
