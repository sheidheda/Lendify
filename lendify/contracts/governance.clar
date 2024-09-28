(use-trait ft-trait .sip-010-trait.sip-010-trait)

(define-data-var proposal-count uint u0)

(define-map proposals
  { id: uint }
  { 
    proposer: principal,
    description: (string-utf8 256),
    votes-for: uint,
    votes-against: uint,
    end-block: uint,
    executed: bool
  }
)

(define-map votes
  { proposal-id: uint, voter: principal }
  { amount: uint }
)

(define-public (create-proposal (description (string-utf8 256)) (voting-period uint))
  (let
    ((proposal-id (var-get proposal-count)))
    (map-set proposals
      { id: proposal-id }
      {
        proposer: tx-sender,
        description: description,
        votes-for: u0,
        votes-against: u0,
        end-block: (+ block-height voting-period),
        executed: false
      }
    )
    (var-set proposal-count (+ proposal-id u1))
    (ok proposal-id)
  )
)

(define-public (vote (proposal-id uint) (amount uint) (vote-for bool) (token <ft-trait>))
  (let
    ((proposal (unwrap! (map-get? proposals { id: proposal-id }) (err u404))))
    (asserts! (< block-height (get end-block proposal)) (err u403))
    (try! (contract-call? token transfer amount tx-sender (as-contract tx-sender)))
    (map-set votes
      { proposal-id: proposal-id, voter: tx-sender }
      { amount: amount }
    )
    (if vote-for
      (map-set proposals { id: proposal-id }
        (merge proposal { votes-for: (+ (get votes-for proposal) amount) }))
      (map-set proposals { id: proposal-id }
        (merge proposal { votes-against: (+ (get votes-against proposal) amount) }))
    )
    (ok true)
  )
)

(define-public (execute-proposal (proposal-id uint))
  (let
    ((proposal (unwrap! (map-get? proposals { id: proposal-id }) (err u404))))
    (asserts! (>= block-height (get end-block proposal)) (err u403))
    (asserts! (not (get executed proposal)) (err u403))
    (asserts! (> (get votes-for proposal) (get votes-against proposal)) (err u403))
    (map-set proposals { id: proposal-id }
      (merge proposal { executed: true })
    )
    (ok true)
  )
)