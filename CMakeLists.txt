cmake_minimum_required(VERSION 3.14)

include(FindVcPkg.cmake)
project(CmakeFlatbuffersTest)

find_package(Flatbuffers CONFIG REQUIRED)
find_program(FLATBUFFERS_FLATC_EXECUTABLE NAMES flatc)

include(BuildFlatBuffers.cmake)

build_flatbuffers(
	"schema.fbs"
	"${CMAKE_CURRENT_SOURCE_DIR}"
	"schema_target"
	""
	"${CMAKE_CURRENT_SOURCE_DIR}"
	""
	""
)

add_executable(main main.cpp)
add_dependencies(main schema_target)
target_link_libraries(main
	PRIVATE
		flatbuffers::flatbuffers
)
