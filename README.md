# acosolver

Hybrid String Constraint Solving for Vulnerability Analysis

[Overview](#overview)

[Evaluation](#evaluation)

[Tool](#tool)

# Overview

ACO-Solver is a tool for search-driven constraint solving for the purpose of
vulnerability analysis. The figure below illustrates how ACO-Solver works.

The solver takes as input an attack condition, *i.e*. a path condition conjoined with an
attack specification used to characterize a security threat
(*e.g.* `.*' or 1 = 1 -- .*` in the case of SQL injection). The solving procedure is
a two stage process:

1) In the first stage, ACO-Solver invokes an external solver in order to solve all the given constraints that are supported by the solver. Solvers can be integrated through the plugin structure of ACO-Solver. For evaluation purposes, we developed plugins for Z3-str2, and CVC4.

2) The remaining constraints can then be solved in the second phase by means of hybrid constraint solving that combines an automata based solver with a search-driven solving procedure based on the [Ant Colony Optimization meta-heuristic](http://dl.acm.org/citation.cfm?id=348603).

![](https://www.dropbox.com/s/t5cbpndjorpweow/archfigure.png?dl=1)

# Evaluation

We conducted our evaluation on a machine equipped with an Intel Core i7 2.4 GHz processor, 8 GB memory, running Apple Mac OS X 10.11 and Sushi v2.0. As external solver, we experimented with Z3-str2 as well as CVC4.

## Benchmark

We extracted attack conditions from the following Java Web applications and services:

* [WebGoat 5.2](https://www.owasp.org/index.php/Category:OWASP_WebGoat_Project):
  a deliberately in-secured Web application/service for the purpose of teaching security vulnerabilities
* [Apache Roller 5.1.1](http://roller.apache.org/): a blogging application with Web Service APIs
* [Pebble 2.6.4](http://pebble.sourceforge.net/): a blogging application with Web service APIs
* [Regain 2.1.0](http://regain.sourceforge.net/download.php?lang=de): a production-grade search engine used internally by one of the biggest drug stores in Europe
* [pubsubhubbub-java 0.3](https://code.google.com/p/pubsubhubbub/): the most popular Java project related to the PubSubHubbub protocol in the Google Code archive
* [rest-auth-proxy](https://github.com/kamranzafar/rest-auth-proxy): an LDAP micro-service
* [TPC-(APP|C|W)](http://www.tpc.org/tpc_app/): standard security benchmark accepted as representative of real environments by the Transactions processing Performance Council

The table below details the vulnerability information for every application of our benchmark. It shows the number of extracted vulnerable and non-vulnerable paths. We verified whether a given path is vulnerable or not through manual inspection and consultation of [NVD](https://nvd.nist.gov/). We encountered the following vulnerability types in our benchmark:

* XML Injection (XML)
* XPath Injection (XPath)
* Cross-Site Scripting (XSS)
* LDAP Injection (LDAP)
* SQL Injection (SQL)

<table class="table-condensed">
<thead>
<tr>
<td align="center">Application</td>
<td>Paths</td>
<td align="center" colspan="5">Vulnerable Paths</td>
<td align="center" colspan="5">Non-Vulnerable Paths</td>
</tr>
</thead>
<tr>
<td></td>
<td></td>
<td>XML</td>
<td>XPath</td>
<td>XSS</td>
<td>LDAP</td>
<td>SQL</td>
<td>XML</td>
<td>XPath</td>
<td>XSS</td>
<td>LDAP</td>
<td>SQL</td>
</tr>
<tbody>
<tr><td>WebGoat</td>
<td align="right">15</td>
<td align="right">1</td>
<td align="right">2</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">8</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">3</td>
</tr>
<tr><td>Roller</td>
<td align="right">13</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">7</td>
<td align="right">0</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">0</td>
</tr>
<tr><td>Pebble</td>
<td align="right">13</td>
<td align="right">2</td>
<td align="right">0</td>
<td align="right">4</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">6</td>
<td align="right">0</td>
<td align="right">0</td>
</tr>
<tr><td>Regain</td>
<td align="right">6</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">0</td>
</tr>
<tr><td>pubsubhubbub-java</td>
<td align="right">4</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">2</td>
<td align="right">0</td>
<td align="right">0</td>
</tr>
<tr><td>rest-auth-proxy</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
</tr>
<tr><td>TPC-APP</td>
<td align="right">12</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">6</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">6</td>
</tr>
<tr><td>TPC-C</td>
<td align="right">34</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">30</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">4</td>
</tr>
<tr><td>TPC-W</td>
<td align="right">6</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">3</td>
</tr>
<tr style="font-weight:bold"><td>Total</td>
<td align="right">104</td>
<td align="right">4</td>
<td align="right">2</td>
<td align="right">10</td>
<td align="right">1</td>
<td align="right">47</td>
<td align="right">9</td>
<td align="right">1</td>
<td align="right">14</td>
<td align="right">0</td>
<td align="right">16</td>
</tr>
</tbody>
</table>

The `acond/` directory of this
repository contains the attack conditions extracted from our benchmark
applications (suffixed with `sol`). It also contains constraints derived from the attack conditions that were supported by
Z3-str2 (suffixed with `z3str2`) and CVC4 (suffixed with `cvc4`), respectively.
The file `acond/README.txt` shows to which application a given attack condition belongs.

## Results

The table below depicts the overall results of our evaluation. The columns are explained in the following:

 * vp: number vulnerable paths
 * nvp: number of non-vulnerable paths
 * t(s): the time taken in second to solve all attack conditions per application
 * &#x2716;: number of failing cases, *i.e.* how many attack conditions could not be solved due to crashes or the presence unsupported operations
 * &#x2714;: number of cases that could be solved by the constraint solver
 * &Delta;: number of cases, out of the failing cases of Z3-str2 or CVC4, that ACO-Solver helped solve
 * TP: true positives (number of vulnerable cases correctly identified)
 * TN: true negatives (number of non-vulnerable cases correctly identified)
 * FP: false positives (number of non-vulnerable cases reported as vulnerable)
 * FN: false negatives (number of vulnerable cases not detected)
 * recall: the percentage of vulnerable cases detected among the total vulnerable cases computed with TP/(TP+FN)*100

<table class="table-condensed">
<thead>
<tr>
<td align="center">Application</td>
<td align="center" colspan="2">Paths</td>
<td align="center" colspan="8">Z3-str2</td>
<td align="center" colspan="9">Z3-str2 + ACO-Solver</td>
<td align="center" colspan="8">CVC4</td>
<td align="center" colspan="9">CVC4 + ACO-Solver</td>
</tr>
</thead>
<tr>
<td></td>
<td align="right">vp</td>
<td align="right">nvp</td>
<td align="right">t(s)</td>
<td align="right">&#x2716;</td>
<td align="right">&#x2714;</td>
<td align="right">TP</td>
<td align="right">TN</td>
<td align="right">FP</td>
<td align="right">FN</td>
<td align="right">recall</td>
<td align="right">t(s)</td>
<td align="right">&Oslash;</td>
<td align="right">&#x2714;</td>
<td align="right">&Delta;</td>
<td align="right">TP</td>
<td align="right">TN</td>
<td align="right">FP</td>
<td align="right">FN</td>
<td align="right">recall</td>
<td align="right">t(s)</td>
<td align="right">&#x2716;</td>
<td align="right">&#x2714;</td>
<td align="right">TP</td>
<td align="right">TN</td>
<td align="right">FP</td>
<td align="right">FN</td>
<td align="right">recall</td>
<td align="right">t(s)</td>
<td align="right">&Oslash;</td>
<td align="right">&#x2714;</td>
<td align="right">&Delta;</td>
<td align="right">TP</td>
<td align="right">TN</td>
<td align="right">FP</td>
<td align="right">FN</td>
<td align="right">recall</td>
</tr>
<tbody>
<tr>
<td>WebGoat</td>
<td align="right">11</td>
<td align="right">4</td>
<td align="right">0.10</td>
<td align="right">11</td>
<td align="right">4</td>
<td align="right">0</td>
<td align="right">4</td>
<td align="right">0</td>
<td align="right">11</td>
<td align="right">0.0</td>
<td align="right">22.23</td>
<td align="right">0</td>
<td align="right">15</td>
<td align="right">11</td>
<td align="right">11</td>
<td align="right">4</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
<td align="right">1.40</td>
<td align="right">1</td>
<td align="right">14</td>
<td align="right">10</td>
<td align="right">4</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">90.9</td>
<td align="right">10.90</td>
<td align="right">0</td>
<td align="right">15</td>
<td align="right">1</td>
<td align="right">11</td>
<td align="right">4</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
</tr>
<tr><td>Roller</td>
<td align="right">3</td>
<td align="right">10</td>
<td align="right">0.00</td>
<td align="right">13</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">10</td>
<td align="right">0</td>
<td align="right">3</td>
<td align="right">0.0</td>
<td align="right">333.96</td>
<td align="right">10</td>
<td align="right">3</td>
<td align="right">3</td>
<td align="right">3</td>
<td align="right">10</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
<td align="right">0.53</td>
<td align="right">10</td>
<td align="right">3</td>
<td align="right">3</td>
<td align="right">10</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
<td align="right">307.24</td>
<td align="right">10</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">3</td>
<td align="right">10</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
</tr>
<tr><td>Pebble</td>
<td align="right">6</td>
<td align="right">7</td>
<td align="right">0.01</td>
<td align="right">12</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">7</td>
<td align="right">0</td>
<td align="right">6</td>
<td align="right">0.0</td>
<td align="right">199.34</td>
<td align="right">5</td>
<td align="right">8</td>
<td align="right">7</td>
<td align="right">6</td>
<td align="right">7</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
<td align="right">0.04</td>
<td align="right">12</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">7</td>
<td align="right">0</td>
<td align="right">6</td>
<td align="right">0.0</td>
<td align="right">205.14</td>
<td align="right">5</td>
<td align="right">8</td>
<td align="right">7</td>
<td align="right">6</td>
<td align="right">7</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
</tr>
<tr><td>Regain</td>
<td align="right">3</td>
<td align="right">3</td>
<td align="right">86.71</td>
<td align="right">0</td>
<td align="right">6</td>
<td align="right">3</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
<td align="right">84.12</td>
<td align="right">0</td>
<td align="right">6</td>
<td align="right">0</td>
<td align="right">3</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
<td align="right">0.61</td>
<td align="right">0</td>
<td align="right">6</td>
<td align="right">3</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
<td align="right">1.47</td>
<td align="right">0</td>
<td align="right">6</td>
<td align="right">0</td>
<td align="right">3</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
</tr>
<tr>
<td>pubsubhubbub-java</td>
<td align="right">1</td>
<td align="right">3</td>
<td align="right">13.33</td>
<td align="right">4</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0.0</td>
<td align="right">61.64</td>
<td align="right">2</td>
<td align="right">2</td>
<td align="right">2</td>
<td align="right">1</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
<td align="right">0.00</td>
<td align="right">4</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0.0</td>
<td align="right">61.34</td>
<td align="right">2</td>
<td align="right">2</td>
<td align="right">2</td>
<td align="right">1</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
</tr>
<tr><td>rest-auth-proxy</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0.00</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0.0</td>
<td align="right">0.40</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">1</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
<td align="right">0.00</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0.93</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">1</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
</tr>
<tr><td>TPC-APP</td>
<td align="right">6</td>
<td align="right">6</td>
<td align="right">0.02</td>
<td align="right">10</td>
<td align="right">2</td>
<td align="right">0</td>
<td align="right">6</td>
<td align="right">0</td>
<td align="right">6</td>
<td align="right">0.0</td>
<td align="right">217.79</td>
<td align="right">7</td>
<td align="right">5</td>
<td align="right">3</td>
<td align="right">2</td>
<td align="right">6</td>
<td align="right">0</td>
<td align="right">4</td>
<td align="right">33.3</td>
<td align="right">0.57</td>
<td align="right">3</td>
<td align="right">9</td>
<td align="right">6</td>
<td align="right">6</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
<td align="right">93.22</td>
<td align="right">3</td>
<td align="right">9</td>
<td align="right">0</td>
<td align="right">6</td>
<td align="right">6</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
</tr>
<tr><td>TPC-C</td>
<td align="right">30</td>
<td align="right">4</td>
<td align="right">0.09</td>
<td align="right">31</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">4</td>
<td align="right">0</td>
<td align="right">30</td>
<td align="right">0.0</td>
<td align="right">596.40</td>
<td align="right">15</td>
<td align="right">19</td>
<td align="right">16</td>
<td align="right">16</td>
<td align="right">4</td>
<td align="right">0</td>
<td align="right">14</td>
<td align="right">53.3</td>
<td align="right">1.50</td>
<td align="right">1</td>
<td align="right">33</td>
<td align="right">30</td>
<td align="right">4</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
<td align="right">47.12</td>
<td align="right">1</td>
<td align="right">33</td>
<td align="right">0</td>
<td align="right">30</td>
<td align="right">4</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
</tr>
<tr><td>TPC-W</td>
<td align="right">3</td>
<td align="right">3</td>
<td align="right">0.02</td>
<td align="right">3</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">3</td>
<td align="right">0.0</td>
<td align="right">2.45</td>
<td align="right">0</td>
<td align="right">6</td>
<td align="right">3</td>
<td align="right">3</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
<td align="right">0.31</td>
<td align="right">0</td>
<td align="right">6</td>
<td align="right">3</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
<td align="right">1.21</td>
<td align="right">0</td>
<td align="right">6</td>
<td align="right">0</td>
<td align="right">3</td>
<td align="right">3</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
</tr>
<tr style="font-weight:bold"><td>Total</td>
<td align="right">64</td>
<td align="right">40</td>
<td align="right">100.28</td>
<td align="right">85</td>
<td align="right">19</td>
<td align="right">3</td>
<td align="right">40</td>
<td align="right">0</td>
<td align="right">61</td>
<td align="right">4.7</td>
<td align="right">1518.33</td>
<td align="right">39</td>
<td align="right">65</td>
<td align="right">46</td>
<td align="right">46</td>
<td align="right">40</td>
<td align="right">0</td>
<td align="right">18</td>
<td align="right">71.9</td>
<td align="right">4.96</td>
<td align="right">32</td>
<td align="right">72</td>
<td align="right">55</td>
<td align="right">40</td>
<td align="right">0</td>
<td align="right">9</td>
<td align="right">85.9</td>
<td align="right">728.57</td>
<td align="right">21</td>
<td align="right">83</td>
<td align="right">11</td>
<td align="right">64</td>
<td align="right">40</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">100.0</td>
</tr>
</tbody>
</table>

To assess the role of Sushi in the second stage of our solving procedure, we ran both Z3-str2 and CVC4 together with a modified version of ACO-Solver where Sushi was switched-off, referred to as modACO-Solver in the following.

When executed with 30s time-out, Z3-str2 + modACO-Solver timed-out on 85 cases with a recall of 4.7% and an overall execution time of 44 min. CVC4 + modACO-Solver timed out on 31 cases, with a recall of 87.5% and an overall execution time of 15.5 min and solved only one more case as compared to running CVC4 standalone.

For both solvers, increasing the timeout per test case to 300s did not result in
the detection of more vulnerable cases as compared to running them with a timeout of 30s. The
following table shows the results in detail.


* &Oslash;(timeout: 30s): Execution time of our test subjects with a timeout of 30s per attack condition
* &Oslash;(timeout: 300s) Execution time of our test subjects with a timeout of 300s per attack condition
* recall: the percentage of vulnerable cases detected among the total vulnerable cases computed with tp/(tp + fn)*100

<table class="table-condensed">
<thead>
<tr>
<td align="center">Application</td>
<td align="center" colspan="3">Z3-str2 + modACO-Solver</td>
<td align="center" colspan="3">CVC4 + modACO-Solver</td>
</tr>
<tr>
<td></td>
<td>&Oslash;(timeout: 30s)</td>
<td>&Oslash;(timeout: 300s)</td>
<td>recall</td>
<td>&Oslash;(timeout: 30s)</td>
<td>&Oslash;(timeout: 300s)</td>
<td>recall</td>
</tr>
</thead>
<tr>
<td>WebGoat</td>
<td align="right">330</td>
<td align="right">3300</td>
<td align="right">0.0</td>
<td align="right">41</td>
<td align="right">310</td>
<td align="right">91.0</td>
</tr>
<tbody><tr><td>Roller</td>
<td align="right">390</td>
<td align="right">3900</td>
<td align="right">0.0</td>
<td align="right">302</td>
<td align="right">3002</td>
<td align="right">100.0</td>
</tr>
<tr>
<td>Pebble</td>
<td align="right">360</td>
<td align="right">3600</td>
<td align="right">0.0</td>
<td align="right">361</td>
<td align="right">4773</td>
<td align="right">0.0</td>
</tr>
<tr><td>Regain</td>
<td align="right">88</td>
<td align="right">91</td>
<td align="right">100.0</td>
<td align="right">2</td>
<td align="right">324</td>
<td align="right">100.0</td>
</tr>
<tr><td>pubsubhubbub-java</td>
<td align="right">133</td>
<td align="right">1213</td>
<td align="right">0.0</td>
<td align="right">90</td>
<td align="right">1572</td>
<td align="right">0.0</td>
</tr>
<tr><td>rest-auth-proxy</td>
<td align="right">30</td>
<td align="right">300</td>
<td align="right">0.0</td>
<td align="right">2</td>
<td align="right">2</td>
<td align="right">100.0</td>
</tr>
<tr><td>TPC-APP</td>
<td align="right">270</td>
<td align="right">2700</td>
<td align="right">0.0</td>
<td align="right">92</td>
<td align="right">902</td>
<td align="right">100.0</td>
</tr>
<tr><td>TPC-C</td>
<td align="right">930</td>
<td align="right">9300</td>
<td align="right">0.0</td>
<td align="right">38</td>
<td align="right">308</td>
<td align="right">100.0</td>
</tr>
<tr><td>TPC-W</td>
<td align="right">120</td>
<td align="right">1200</td>
<td align="right">0.0</td>
<td align="right">1</td>
<td align="right">1</td>
<td align="right">100.0</td>
</tr>
<tr style="font-weight:bold"><td>Total</td>
<td align="right">2652</td>
<td align="right">25605</td>
<td align="right">4.7</td>
<td align="right">928</td>
<td align="right">11194</td>
<td align="right">87.5</td>
</tr>
</tbody></table>




# Tool

The ACO-Solver tool has the following requirements:

* Mac OS X / Linux
* Java 1.8
* Sushi 2.0: a Java archive can be requested from the main authors from [here](http://people.hofstra.edu/Xiang_Fu/XiangFu/projects/SAFELI/SUSHI.php)
* Z3-str2: we used revision [2e52601](https://github.com/z3str/Z3-str/commit/2e52601). Installation instructions are available on the [github page](https://github.com/z3str/Z3-str).
* CVC4: for our experiments, we used [version 4.1](http://cvc4.cs.nyu.edu/builds/misc/cvc4-1.4.1-prerelease-2016-01-03.tar.gz). Installation instructions are available on the [CVC4 Wiki](http://cvc4.cs.nyu.edu/wiki/User_Manual).

The ACO-Solver tool can be downloaded from
[here](https://www.dropbox.com/s/jjf3b6jkhuv2ysk/aco.zip?dl=1). The zip archive
contains the file ``acosolver.jar`` (*i.e.*, the main tool) and the plugin files
``cvc4-plugin.jar`` and ``z3-plugin.jar``, respectively. These plugins are important for
ACO-Solver to communicate with the external solvers in the first phase of the
solving procedure.

For running ACO-Solver, one can use the helper script script `solve.sh` that is
available in the `scripts/` directory of this repository with ``aco`` as
parameter.  Before running the script, please make sure that the variable
definitions at the top of `solve.sh` are pointing to the right locations. The variable explanations can be found inside the script.

```bash
./solve.sh aco
solve ../acond/AuthorizationServlet0.sol
solve ../acond/BackDoors0.sol
solve ...
```

# Constraint Solvers

For running CVC4, and Z3-str2 on our benchmark, one can use the `solve.sh`
script that is available in the `scripts/` directory of this repository.  Before running the script, please make sure that the paths of CVC4 and Z3-str2 are correctly defined. To decide which solver should be invoked, one can pass to the script either ``cvc4`` or ``z3str2``.

```bash
./solve.sh cvc4
solve ../acond/AuthorizationServlet0.cvc4 ...
solve ../acond/BackDoors0.cvc4 ...
solve ...
```

For solving single attack conditions, the following two commands illustrate how CVC4 and Z3-str2 can be invoked directly:

```bash
cvc4 --lang smt XPATHInjection0.cvc4
```

```bash
./Z3-str.py -f ListTag0.z3str2
```
