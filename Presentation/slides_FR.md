---
title: Template
separator: <!--h-->
verticalSeparator: <!--v-->
theme: blood
revealOptions:
  auto-animate: true
---

## Les tests de performances

<img src="img/zenika_logo.svg" alt="drawing" width="400"/>

Note: authors : 
 - S.LAVAZAIS
 - D.SIX

sources:
TO COMPLETE

<!--v-->

## Plan

1. La performance, qu'est-ce que c'est ?
_montrer ce qu'on entend par "performance"_
_expliquer les différents niveaux de performance évaluable_
_du code à la releases_
2. Qu'est-ce qu'un test de charge ?
   1. test de charge
_évaluation des performances par rapport à une cible donnée sur un délai d'une heure_
   2. test d'endurance
_évaluation des performances par rapport à une durée de fonctionnement sans problème_
   3. test sur un pic de charge
_évaluation des performances sur un pic d'activité sur un délai très court avec des répétitions_
   4. test aux limites
_évaluation des performances jusqu'au point de rupture_
3. Qu'est-ce qu'un test type micro-benchmark
_explication des différents cas de test possible_
Note:

TODO :

## Les tests de performance


Note: authors :
- S.LAVAZAIS
- D.SIX

Sources:
- [Wikipedia - software performance testing](https://en.wikipedia.org/wiki/Software_performance_testing)

<!--v-->

## Introduction - Sommaire

1. Les tests performance, qu'est-ce que c'est ?
2. Quel type de test pratiquer?
3. Tests en isolement avec ??? 
4. Tests de charge avec Taurus
5. Demonstration

Note:
For this presentation, we're going to see roughly through the performance testing, and we're going to see how to work a solution to make performance testing easier and automated, "Taurus" by Blazemeter.

But first, let me introduce you what is performance testing and how many kinds of tests we can
practice against an application.

1. Les testes de performance, qu'est-ce que c'est ?
2. Quel type de test pratiquer?
   1. test en isolement
   2. test de charge
   3. test en stress
   4. test de pic
   5. test au limites
   6. test d'endurance
3. Tests en isolement avec ???
4. Tests de charge avec Taurus
5. Demo
6. Merci !

<!--h-->

### Les testes performance, qu'est-ce que c'est ?

<img src="img/what-is-perf-1.png" alt="drawing" width="500"/>

Note:
Les tests de performances, c'est la capacité à mettre une application et toutes ses dépendances dans un context virtuel 
ou réel et observer comment ces composants ce comportent.
On peut ainsi en déterminer des axes d'amélioration pour l'application testée.

(point à discuter avec @sixdouglas)

<!--v-->

<!-- .slide: data-auto-animate -->
### Les testes performance, qu'est-ce que c'est ? 

<div style="display: flex">
   <div>
      <div style="font-size: xx-large">temps de réponse</div>
      <img src="img/what-is-perf-response-time.jpg" alt="drawing" width="400"/>
   </div>
   <div>
      <div style="font-size: xx-large">les resources utilisées</div>
      <img src="img/what-is-perf-resources-usage.jpg" alt="drawing" width="400"/>
   </div>
   <div>
      <div style="font-size: xx-large">l'adaptation</div>
      <img src="img/what-is-perf-scalability.jpg" alt="drawing" width="400"/>
   </div>
</div>

Note:
Voici les principals métriques qu'un test de performance évalue :
 - Le temps de réponse global (sur le pourcentage de toute les réponses) et à un instant T.
 - La quantité de resources utilisées
 - Mesure de la capacité d'adaptation / de la scalabilité
<!--v-->

<!-- .slide: data-auto-animate -->
### Les testes performance, qu'est-ce que c'est ?

<div style="display: flex">
   <div>
      <div style="font-size: xx-large">les coupûres</div>
      <img src="img/what-is-perf-downtime.jpeg" alt="drawing" width="400"/>
   </div>
   <div>
      <div style="font-size: xx-large">bug / bottleneck</div>
      <img src="img/what-is-perf-bottleneck.jpeg" alt="drawing" width="400"/>
   </div>
   <div>
      <div style="font-size: xx-large">la sécurité</div>
      <img src="img/what-is-perf-security.jpg" alt="drawing" width="400"/>
   </div>
</div>

Note:
Les tests de performance permet également de : 
  - De prévenir les coupures dû à la charge
  - De détecter les bugs non couverts / les goulots d'étranglement
  - D'atténuer les failles de sécurités
<!--v-->

### Quel type de test pratiquer?

1. test en isolement
2. test de charge
3. test en stress
4. test de pic
5. test aux limites
6. test d'endurance

Note:
Voici les différents tests de performance praticable

<!--v-->

### test en isolement

![](img/what-tests-isolation-test.png)

Note:
this kind of test is to perform on a test bench (an isolated test case / context) by repeating test execution.

The tested part can be a bunch of code, or an isolated system.

<!--v-->

### test de charge

![](img/what-tests-load-test.png)

Note:
The load test is the simplest way to test an application.
The objective is to check if the application can manage the limit that has been decided before the test.
The application dependencies infrastructure services should also be monitored during the test.

in build context, this test can be used to monitor the application response time, and the objective to maintain.

<!--v-->

### test en stress

![](img/what-tests-stress-test.png)

Note:
This kind of test is designed to determine the response limit for the tested application and/or the application
dependencies.

(schema to redo)

<!--v-->

### test de pic

![](img/what-tests-spike-test.png)

Note:
The spike testing aims to determine the performance issues when dramatic changes occur with application, like a large
amount of user connect at the same-time or a large fewer of users that disconnect.

<!--v-->

### test aux limites

![](img/what-tests-breakpoint-test.png)

Note:
This kind of test is to evaluate the load and the time when the tested application will fail.
Breakpoint testing is often referred to as Capacity testing because it can be use to determine if the
SLA (Service Level Agreement) can be managed by the tested application.

<!--v-->

### soaking testing

![](img/what-tests-soaking-test.png)

Note:
The soaking testing or the "Endurance Testing" is done to determine if the tested application can sustain a continuous
load during a tremendous amount of time.
Like load testing, the application dependencies infrastructure services should also be monitored during the test.

<!--h-->

### Test with Taurus By Blazemeter

Note:

