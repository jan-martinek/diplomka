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

# std. error hodnocení projektů

SELECT projects.name, projects.id, firstRatingIneligibility, secondRatingIneligibility, STD(r1.rating), STD(r2.rating)
FROM projects, ratings as r1, ratings as r2
WHERE (r1.projectID = projects.id AND r1.phase = 'firstRating')
AND (r2.projectID = projects.id AND r2.phase = 'secondRating')
GROUP BY projects.id

# std. error v jednotlivých kolech

SELECT roundID, STD(r1.rating), STD(r2.rating)
FROM projects, ratings as r1, ratings as r2
WHERE (r1.projectID = projects.id AND r1.phase = 'firstRating')
AND (r2.projectID = projects.id AND r2.phase = 'secondRating')
GROUP BY projects.roundID

# std. error v jednotlivých kolech bez projektů, které dostaly nedoporučení

SELECT roundID, STD(r1.rating), STD(r2.rating)
FROM projects, ratings as r1, ratings as r2
WHERE (r1.projectID = projects.id AND r1.phase = 'firstRating')
AND (r2.projectID = projects.id AND r2.phase = 'secondRating')
AND projects.secondRatingIneligibility < 2
GROUP BY projects.roundID

