(ns lp-parser-emitter.test.taxonomies
  (:require [clojure.test :refer :all]
            [lp-parser-emitter.taxonomies :as t]))

(deftest find-node-test
  (let [tax-xml (slurp "../resources/taxonomy.xml")]
    (is (= "Cape Town"
           (-> (t/find-node tax-xml "Cape Town")
               t/node-name)))))

(deftest parent-test
  (let [tax-xml (slurp "../resources/taxonomy.xml")
        cape-town (t/find-node tax-xml "Cape Town")]
    (is (= "South Africa"
           (-> cape-town
               t/parent
               t/node-name)))))

(deftest parent-test
  (let [tax-xml (slurp "../resources/taxonomy.xml")
        cape-town (t/find-node tax-xml "Cape Town")]
    (is (= ["Table Mountain National Park"]
           (->> cape-town
                t/children
                (map t/node-name))))))
