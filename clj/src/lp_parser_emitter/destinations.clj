(ns lp-parser-emitter.destinations
  (:gen-class)
  (:require [lp-parser-emitter.xml :as xml]
            [lp-parser-emitter.taxonomies :as tax]
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

(defn- node-name->filename
  "Given a Title Case Name returns a file_name.html"
  [node-name]
  (if node-name
    (-> node-name
        string/lower-case
        (string/replace #"\W" "_")
        (str ".html"))
    "#"))

(defn filename
  "Given a destination node, return it's title."
  [dest-node]
  (-> dest-node title node-name->filename))

(defn attributes
  "Given a destination node, return attributes for template rendering."
  [taxonomies-xml dest-node]
  (let [region (title dest-node)
        tax-node (tax/find-node taxonomies-xml region)
        parent-name (tax/node-name (tax/parent tax-node))
        children-names (map tax/node-name (tax/children tax-node))]
    {:region region
     :description (overview dest-node)
     :super_region {:name parent-name
                    :file (node-name->filename parent-name)}
     :sub_regions (map #(hash-map :name % :file (node-name->filename %))
                       children-names)}))

