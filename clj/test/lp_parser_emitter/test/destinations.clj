(ns lp-parser-emitter.test.destinations
  (:require [clojure.test :refer :all]
            [clojure.data.zip.xml :as zip-xml]
            [lp-parser-emitter.destinations :as d]))

(deftest find-destination-test
  (let [dest-xml (d/lazy-xml "../resources/destinations.xml")]
    (is (= (zip-xml/attr (d/find-destination dest-xml "Cape Town") :title)
           "Cape Town"))))
