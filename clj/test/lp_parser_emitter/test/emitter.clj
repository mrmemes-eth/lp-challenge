(ns lp-parser-emitter.test.emitter
  (:require [clojure.test :refer :all]
            [lp-parser-emitter.destinations :as d]
            [lp-parser-emitter.xml :as xml]
            [lp-parser-emitter.emitter :as e]))

(deftest spit-html-test
  (testing "emits the correct number of files"
    (let [dest-nodes (d/destinations (xml/lazy "../resources/destinations.xml"))]
      (e/spit-html dest-nodes "build"))
    ; there are 24 destinations and one CSS file
    (is (= 25
           (count (rest (file-seq (clojure.java.io/file "./build"))))))))
