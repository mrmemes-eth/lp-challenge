(ns lp-parser-emitter.destinations
  (:gen-class)
  (:require [lp-parser-emitter.xml :as xml]
            [clojure.data.zip.xml :as zip-xml]
            [clojure.string :as string]))

(defn destinations
  "Given a lazy seq of XML, lazily yield parsed destinations."
  [dest-xml]
  (zip-xml/xml-> dest-xml :destination))

(defn find-destination
  "Given a lazy seq of XML and a destination title, yield a destination node
   whose title matches the provided title."
  [dest-xml title]
  (zip-xml/xml1-> dest-xml
                  destinations
                  (zip-xml/attr= :title title)))

(defn title
  "Given a destination node, return it's title."
  [dest-node]
  (zip-xml/attr dest-node :title))

(defn overview
  "Given a destination node, return it's overview"
  [dest-node]
  (zip-xml/xml1-> dest-node
                  :introductory
                  :introduction
                  :overview
                  zip-xml/text))

(defn filename
  "Given a destination node, return it's title."
  [dest-node]
  (-> dest-node
      title
      string/lower-case
      (string/replace #"\W" "_")
      (str ".html")))

