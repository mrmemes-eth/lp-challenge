(ns lp-parser-emitter.core
  (:gen-class)
  (:require [clojure.tools.cli :as cli]
            [clj-time.core :as time]
            [lp-parser-emitter.destinations :as dest]
            [lp-parser-emitter.xml :as xml]
            [lp-parser-emitter.emitter :as emit]))

(def cli-options
  [["-o"
    "--output-directory DIRECTORY"
    "Directory to output destination HTML to."
    :default "./build"]
   ["-h" "--help" "Show this help text."]])

(defn usage [options-summary]
  (->> ["Usage: lp-process <taxonomy-xml-path> <destinations-xml-path>\n"
        "Options:"
        options-summary]
       (clojure.string/join \newline)))

(defn exit [status msg]
  (println msg)
  (System/exit status))

(defn -main
  "primary executable interface"
  [& args]
  (let [{:keys [options arguments summary]} (cli/parse-opts args cli-options)
        [taxonomy-xml destinations-xml] arguments
        start-time (time/now)]
    (cond
     (:help options) (exit 0 (usage summary))
     (not= (count arguments) 2) (exit 1 (usage summary)))
    (let [dest-nodes (dest/destinations (xml/lazy destinations-xml))
          tax-xml (slurp taxonomy-xml)]
      (emit/spit-html dest-nodes tax-xml "build")
      (println "Finished processing in:"
               (/ (time/in-millis (time/interval start-time (time/now))) 1E3)
               "seconds."))))
