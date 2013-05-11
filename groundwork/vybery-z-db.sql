# seznam projektů s cenami + data pro slope chart nedoporuceni k podpore

SELECT name, amount, roundID, negotiatedAmount, firstRating, firstRatingIneligibility, secondRating, secondRatingIneligibility FROM projects;


# data pro slope chart nedoporuceni k podpore
# zbytecne :-D

SELECT projects.name, count(*) AS notEl FROM projects, eligibilities AS el
WHERE projects.id = el.projectID AND el.notEligible = 1 AND el.phase = 'firstRating'
GROUP BY projects.id;

SELECT projects.name, count(*) AS notEl FROM projects, eligibilities AS el
WHERE projects.id = el.projectID AND el.notEligible = 1 AND el.phase = 'secondRating'
GROUP BY projects.id;

# wtf, skutečně?

SELECT roundID, STD(rating), ratings.phase, STD(firstRatingIneligibility), STD(secondRatingIneligibility) FROM ratings LEFT JOIN projects ON ratings.projectID = projects.id
GROUP BY projects.roundID, ratings.phase