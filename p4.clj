(ns p4
  (:require [i4 :as input]))

(defn transpose [m] (apply mapv vector m))

(defn- mark-board [a board]
  (reduce #(if (= a %2)
             (assoc %1 :m? true :v (conj (:v %1) -1))
             (assoc %1 :v (conj (:v %1) %2)))
          {:m? false :v []} board))

(defn- bingo? [board]
  (let [rows        (partition 5 board)
        check-row   (fn [row] (every? #(= % -1) row))]
    (true? (or (some check-row rows)
               (some check-row (transpose rows))))))

(defn bingo-solver ([lose? answers boards]
  (let [a           (first answers)
        r           (rest answers)
        b           (map #(mark-board a %) boards)
        mark-filter (fn [boards] (map :v (filter :m? boards)))
        any-bingo?  (fn [coll] (reduce #(if (bingo? %2) %2 %1) false coll))
        bingo       (any-bingo? (mark-filter b))
        score       (fn [bingo] (reduce #(if (= %2 -1) %1 (+ %1 %2)) 0 bingo))]
    (if (and lose? (> (count b) 1))
      (recur lose? r (remove bingo? (map :v b)))
      (if bingo
        (* (score bingo) a)
        (recur lose? r (map :v b))))))
  ([answers boards] (bingo-solver false answers boards)))

(bingo-solver input/answers (partition 25 input/bingo)) ;part 1
(bingo-solver true input/answers (partition 25 input/bingo)) ;part 2
