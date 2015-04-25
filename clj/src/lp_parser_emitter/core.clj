(ns lp-parser-emitter.core
  (:gen-class)
  (:require [clojure.tools.cli :as cli]
            [clj-time.core :as time]))

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
    (let [elapsed-millis (time/in-millis (time/interval start-time (time/now)))]
      (println "Finished processing in:" (/ elapsed-millis 1E3) "seconds."))))
