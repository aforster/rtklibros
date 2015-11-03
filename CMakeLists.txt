cmake_minimum_required(VERSION 2.8.3)
project(rtklib)

find_package(catkin_simple REQUIRED)

catkin_simple(ALL_DEPS_REQUIRED)

include_directories(src ${catkin_INCLUDE_DIRS}) 

add_definitions("-Wall -ansi -pedantic -I$(SRC) -DTRACE -lpthread
 -DENAGLO -DENAQZS -DENAGAL -DNFREQ=3") 

link_libraries(m)

include_directories ("${PROJECT_SOURCE_DIR}/src")

#pos2kml
cs_add_library(convkml src/convkml.c)
cs_add_library(solution src/solution.c)
cs_add_library(geoid src/geoid.c)
cs_add_library(rtkcmn src/rtkcmn.c)

cs_add_executable(pos2kml app/pos2kml/pos2kml.c)
target_link_libraries(pos2kml convkml solution geoid rtkcmn solution)

#str2str
cs_add_library(ss2 src/rcv/ss2.c)
cs_add_library(crescent src/rcv/crescent.c)
cs_add_library(skytraq src/rcv/skytraq.c)
cs_add_library(gw10 src/rcv/gw10.c)
cs_add_library(javad src/rcv/javad.c)
cs_add_library(stream src/stream.c)
cs_add_library(sbas src/sbas.c)
cs_add_library(nvs src/rcv/nvs.c)
cs_add_library(rt17 src/rcv/rt17.c)
cs_add_library(binex src/rcv/binex.c)
cs_add_library(ublox src/rcv/ublox.c src/rcvraw.c)
target_link_libraries(ublox ss2 crescent gw10 javad skytraq crescent sbas novatel
                      rtkcmn rinex rtcm nvs rt17 binex)
cs_add_library(novatel src/rcv/novatel.c)
cs_add_library(streamsvr src/streamsvr.c)

cs_add_executable(str2str app/str2str/str2str.c)
target_link_libraries(str2str stream rtkcmn solution geoid ublox skytraq streamsvr pthread)

#rnx2rtkp

cs_add_library(rinex  src/rinex.c)
cs_add_library(rtkpos  src/rtkpos.c)
cs_add_library(ephemeris  src/ephemeris.c)
cs_add_library(qzslex src/qzslex.c)
target_link_libraries(rtkpos lambda ppp pntpos ephemeris qzslex)
cs_add_library(postpos  src/postpos.c)
target_link_libraries(postpos sbas rtkpos rtcm rinex)

cs_add_library(lambda  src/lambda.c)
cs_add_library(preceph  src/preceph.c)
cs_add_library(ionex src/ionex.c)
cs_add_library(pntpos  src/pntpos.c)
target_link_libraries(pntpos ionex ephemeris preceph)
cs_add_library(options src/options.c)
cs_add_library(ppp  src/ppp.c src/ppp_ar.c)
target_link_libraries(ppp pntpos)

cs_add_library(rtcm  src/rtcm.c src/rtcm2.c src/rtcm3.c src/rtcm3e.c)

cs_add_executable(rnx2rtkp app/rnx2rtkp/rnx2rtkp.c)
target_link_libraries(rnx2rtkp rtkcmn postpos solution ionex
geoid preceph pntpos ephemeris options rtcm ionex)

#convbin
cs_add_library(convrnx src/convrnx.c)
target_link_libraries(convrnx rtkcmn sbas rtkpos rtcm rinex)

cs_add_executable(convbin app/convbin/convbin.c src/rcvraw.c)
target_link_libraries(convbin ublox rtkcmn rinex sbas convrnx rtcm skytraq
rtkcmn rtksvr rtkpos geoid solution lambda
sbas stream rtcm preceph options pntpos ppp ublox
 ephemeris rinex ionex)

#rtkrcv
cs_add_library(rtksvr src/rtksvr.cc)
cs_add_executable(rtkrcv app/rtkrcv/rtkrcvros.cc)
add_dependencies(rtkrcv rtklibros_generate_messages_cpp)
target_link_libraries(rtkrcv rtkcmn rtksvr rtkpos geoid solution lambda
sbas stream rtcm preceph options pntpos ppp ublox
 ephemeris rinex ionex)

