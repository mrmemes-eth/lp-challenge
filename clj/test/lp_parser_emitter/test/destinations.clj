(ns lp-parser-emitter.test.destinations
  (:require [clojure.test :refer :all]
            [clojure.data.zip.xml :as zip-xml]
            [lp-parser-emitter.xml :as x]
            [lp-parser-emitter.destinations :as d]))

(deftest destinations-test
  (let [dest-xml (x/lazy "../resources/destinations.xml")]
    (is (= 24 (count (d/destinations dest-xml))))))

(deftest find-destination-test
  (let [dest-xml (x/lazy "../resources/destinations.xml")]
    (is (= "Cape Town"
           (zip-xml/attr (d/find-destination dest-xml "Cape Town") :title)))))

(deftest title-test
  (let [dest-xml (x/lazy "../resources/destinations.xml")]
    (is (= "Cape Town"
           (d/title (d/find-destination dest-xml "Cape Town"))))))

(deftest filename-test
  (let [dest-xml (x/lazy "../resources/destinations.xml")]
    (is (= "cape_town.html"
           (d/filename (d/find-destination dest-xml "Cape Town"))))))

(deftest overview-test
  (let [dest-xml (x/lazy "../resources/destinations.xml")]
    (is (re-matches #"^\sGood-looking, fun-loving, sporty and sociable.*"
                    (d/overview (d/find-destination dest-xml "Cape Town"))))))
