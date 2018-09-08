#!/usr/bin/env bash

echo ######### PRE FLIGHT CHECKS BEFORE BUILD #########

mvn clean

echo ######### BUILDING SINGLE PAGE FRONTEND APP #########

cd ui/js
npm install
npm run build

echo ######### BUILDING API BACKEND #########

cd ../..

mvn install

echo ######### STARTING RESTFUL-BOOKER-PLATFORM #########

trap "kill 0" EXIT

java -jar -Dspring.profiles.active=dev auth/target/restful-booker-platform-auth-*-SNAPSHOT.jar &
java -jar -Dspring.profiles.active=dev booking/target/restful-booker-platform-booking-*-SNAPSHOT.jar &
java -jar -Dspring.profiles.active=dev room/target/restful-booker-platform-room-*-SNAPSHOT.jar &
java -jar -Dspring.profiles.active=dev report/target/restful-booker-platform-report-*-SNAPSHOT.jar &
java -jar -Dspring.profiles.active=dev search/target/restful-booker-platform-search-*-SNAPSHOT.jar &
java -jar -Dspring.profiles.active=dev ui/api/target/restful-booker-platform-ui-*-SNAPSHOT.jar &

wait