# acosolver

Hybrid String Constraint Solving for Vulnerability Analysis


Table of Contents:
------------------

[Overview](#overview): General description of our approach and the tool architecture

[Evaluation](#evaluation): Evaluation details

[Tool](#tool): Requirements and installation instructions

# Overview

ACO-Solver is a tool for search-driven constraint solving for the purpose of
vulnerability analysis. The figure below illustrates how ACO-Solver works:


![](https://www.dropbox.com/s/t5cbpndjorpweow/archfigure.png?dl=1)

The solver takes as input an attack condition, *i.e*. a path condition conjoined with an
attack specification used to characterize a security threat
(*e.g.* `.*' or 1 = 1 -- .*` in the case of SQL injection). The solving procedure is
a two stage process:

1) In the first stage, ACO-Solver invokes an external solver in order to solve all the given constraints that are supported by the solver. External solvers can be integrated through the plugin structure of ACO-Solver. For evaluation purposes, we have developed plugins for Z3-str2 and CVC4.

2) The remaining constraints can then be solved in the second phase by means of hybrid constraint solving that combines an automata based solver (we use Sushi) with a search-driven solving procedure based on the [Ant Colony Optimization meta-heuristic](http://dl.acm.org/citation.cfm?id=348603).



# Evaluation

We have conducted our evaluation on a machine equipped with an Intel Core i7 2.4 GHz processor, 8 GB memory, running Apple Mac OS X 10.11 and [Sushi (v2.0)](http://people.hofstra.edu/Xiang_Fu/XiangFu/projects/SAFELI/SUSHI.php). As external solver, we have experimented with [Z3-str2 (commit 2e52601)](https://github.com/z3str/Z3-str/commit/2e52601) as well as [CVC4 (v1.4.1)](http://cvc4.cs.nyu.edu/builds/misc/cvc4-1.4.1-prerelease-2016-01-03.tar.gz).

## Benchmark

We have extracted attack conditions from the following Java Web applications and services:

* [WebGoat 5.2](https://www.owasp.org/index.php/Category:OWASP_WebGoat_Project):
  a deliberately in-secured Web application/service for the purpose of teaching security vulnerabilities
* [Apache Roller 5.1.1](http://roller.apache.org/): a blogging application with Web Service APIs
* [Pebble 2.6.4](http://pebble.sourceforge.net/): a blogging application with Web service APIs
* [Regain 2.1.0](http://regain.sourceforge.net/download.php?lang=de): a production-grade search engine used internally by one of the biggest drug stores in Europe
* [pubsubhubbub-java 0.3](https://code.google.com/p/pubsubhubbub/): the most popular Java project related to the PubSubHubbub protocol in the Google Code archive
* [rest-auth-proxy](https://github.com/kamranzafar/rest-auth-proxy): an LDAP micro-service
* [TPC-(APP|C|W)](http://www.tpc.org/tpc_app/): standard security benchmark accepted as representative of real environments by the Transactions processing Performance Council

The table below details the vulnerability information for every application of our benchmark. It shows the number of extracted vulnerable and non-vulnerable paths. We have verified whether a given path is vulnerable or not through manual inspection and consultation of [NVD](https://nvd.nist.gov/) and have encountered the following vulnerability types in our benchmark:

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

### Overall results

The table below depicts the overall results of our evaluation. The columns are explained in the following:

 * vp: number of vulnerable paths
 * nvp: number of non-vulnerable paths
 * t(s): the time taken in seconds to solve all the attack conditions per application
 * &#x2716;: number of failing cases, *i.e.* how many attack conditions could not be solved due to crashes or the presence of unsupported operations
 * &#x2714;: number of cases that could be solved by the constraint solver
 * &Delta;: number of cases, out of the failing cases of Z3-str2 or CVC4, that ACO-Solver helped to solve
 * &Oslash;: number of timeout cases (with a timeout of 30s)
 * TP: true positives (number of vulnerable cases correctly identified)
 * TN: true negatives (number of non-vulnerable cases correctly identified)
 * FP: false positives (number of non-vulnerable cases reported as vulnerable)
 * FN: false negatives (number of vulnerable cases not detected)
 * recall: the percentage of vulnerable cases detected from among the total vulnerable cases computed with TP/(TP+FN)*100

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


### Detailed results

The table below depicts the detailed results of our evaluation. The columns are explained in the following:

 * Application: the test subject
 * File: an attack condition extracted from a test subject
 * Vulnerable: shows whether the test subject is vulnerable or not
 * Vulnerability Type: the kind of vulnerability to which the path is vulnerable to
 * t(s): the time taken in seconds to solve all the attack conditions per application
 * Output: the solving result reported by the solver:
    * FAIL: Solver reported error
    * UNSAT: Solver reported UNSAT
    * SAT: Solver reported SAT
    * TIMEOUT: Solver could not find result within 30s
 * &Oslash;: number of timeout cases (with a timeout of 30s)
 * &#x2716;: number of failing cases, *i.e.* how many attack conditions could not be solved due to crashes or the presence of unsupported operations
 * TP: true positives (number of vulnerable cases correctly identified)
 * TN: true negatives (number of non-vulnerable cases correctly identified)
 * FP: false positives (number of non-vulnerable cases reported as vulnerable)
 * FN: false negatives (number of vulnerable cases not detected)

<table class="table-condensed">
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <col  >
 <tr  >
  <td align="center">Application</td>
  <td align="center">File</td>
  <td align="center">Vulnerable</td>
  <td align="center">Vunlerability Type</td>
  <td colspan=8 align="center">Z3str2</td>
  <td colspan=8 align="center">Z3Str2 + ACO-Solver</td>
  <td colspan=8 align="center">CVC4</td>
  <td colspan=8 align="center" >CVC4 + ACO-Solver</td>
 </tr>
 <tr  >
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td >Output</td>
  <td  >t(s)</td>
  <td  >TP</td>
  <td  >TN</td>
  <td  >FP</td>
  <td  >FN</td>
  <td  >&Oslash;</td>
  <td  >&#x2716;</td>
  <td >Output</td>
  <td  >t(s)</td>
  <td  >TP</td>
  <td  >TN</td>
  <td  >FP</td>
  <td  >FN</td>
  <td  >&Oslash;</td>
  <td  >&#x2716;</td>
  <td  >Output</td>
  <td  >t(s)</td>
  <td  >TP</td>
  <td  >TN</td>
  <td  >FP</td>
  <td  >FN</td>
  <td  >&Oslash;</td>
  <td  >&#x2716;</td>
  <td  >Output</td>
  <td  >t(s)</td>
  <td  >TP</td>
  <td  >TN</td>
  <td  >FP</td>
  <td  >FN</td>
  <td  >&Oslash;</td>
  <td  >&#x2716;</td>
 </tr>
 <tr  >
  <td rowspan=15 >WebGoat</td>
  <td  >BackDoors0</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >2.755</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.07</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >1.454</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >BlindNumericSqlInjection0</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >2.093</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.37</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >1.337</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >BlindStringSqlInjection0</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.628</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.07</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >1.369</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >InsecureLogin</td>
  <td  >no</td>
  <td  >SQL</td>
  <td  >UNSAT</td>
  <td  align=right >0.008</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.199</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.019</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.167</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >MultiLevelLogin1</td>
  <td  >no</td>
  <td  >SQL</td>
  <td  >UNSAT</td>
  <td  align=right >0.074</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.187</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.076</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.153</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >MultiLevelLogin2</td>
  <td  >no</td>
  <td  >SQL</td>
  <td  >UNSAT</td>
  <td  align=right >0.008</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.135</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.016</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.149</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >SqlAddData0</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >2.034</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.03</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >1.369</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >SqlModifyData0</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >2.33</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.03</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >1.397</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >SqlNumericInjection0</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >2.396</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.35</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >1.252</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >SqlStringInjection0</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >2.673</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.03</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.184</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >WsSAXInjection0</td>
  <td  >yes</td>
  <td  >XML</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >0.971</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.161</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >WsSqlInjection0</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.803</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.26</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.4</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >XPATHInjection0</td>
  <td  >yes</td>
  <td  >XPATH</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.245</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.03</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.191</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >XPATHInjection1</td>
  <td  >yes</td>
  <td  >XPATH</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.585</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.03</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.179</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >XPATHInjection2</td>
  <td  >no</td>
  <td  >XPATH</td>
  <td  >UNSAT</td>
  <td  align=right >0.008</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.195</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.014</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.133</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td rowspan=13   >Roller</td>
  <td  >CommentDataServlet0</td>
  <td  >no</td>
  <td  >XSS</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.481</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.484</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >CommentDataServlet1</td>
  <td  >yes</td>
  <td  >XSS</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.848</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.14</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.391</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >CommentDataServlet2</td>
  <td  >no</td>
  <td  >XSS</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >31.442</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >31.442</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >CommentDataServlet3</td>
  <td  >yes</td>
  <td  >XSS</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.29</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.15</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.285</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >CommentDataServlet4</td>
  <td  >no</td>
  <td  >XSS</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.842</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >31.491</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >AuthorizationServlet0</td>
  <td  >yes</td>
  <td  >XSS</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >25.769</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.24</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.285</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OpenSearchSevlet0</td>
  <td  >no</td>
  <td  >XML</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.744</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.62</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OpenSearchSevlet1</td>
  <td  >no</td>
  <td  >XML</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.294</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.312</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OpenSearchSevlet2</td>
  <td  >no</td>
  <td  >XML</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.302</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.312</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OpenSearchSevlet3</td>
  <td  >no</td>
  <td  >XML</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.195</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.337</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OpenSearchSevlet4</td>
  <td  >no</td>
  <td  >XML</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.228</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.35</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OpenSearchSevlet5</td>
  <td  >no</td>
  <td  >XML</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.272</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.408</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OpenSearchSevlet6</td>
  <td  >no</td>
  <td  >XML</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.248</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.522</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td rowspan=13   >Pebble</td>
  <td  >ViewFilesAction0</td>
  <td  >no</td>
  <td  >XML</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >UNSAT</td>
  <td  align=right >0.148</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0.022</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >UNSAT</td>
  <td  align=right >0.232</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >ViewFilesAction1</td>
  <td  >yes</td>
  <td  >XML</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >21.412</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >23.43</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >ViewFilesAction2</td>
  <td  >yes</td>
  <td  >XML</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >21.743</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >25.164</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >SaveBlogEntryAction0</td>
  <td  >yes</td>
  <td  >XSS</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >0.912</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.032</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >SaveBlogEntryAction1</td>
  <td  >yes</td>
  <td  >XSS</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >0.86</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >0.987</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >SaveBlogEntryAction2</td>
  <td  >yes</td>
  <td  >XSS</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >0.962</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.01</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >SaveBlogEntryAction3</td>
  <td  >yes</td>
  <td  >XSS</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.05</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.055</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >SaveBlogEntryAction4</td>
  <td  >no</td>
  <td  >XSS</td>
  <td  >UNSAT</td>
  <td  align=right >0.008</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.325</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.018</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.257</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >HTMLDecorator0</td>
  <td  >no</td>
  <td  >XSS</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.187</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.385</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >HTMLDecorator1</td>
  <td  >no</td>
  <td  >XSS</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.367</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.387</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >HTMLDecorator2</td>
  <td  >no</td>
  <td  >XSS</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.441</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.385</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >HTMLDecorator3</td>
  <td  >no</td>
  <td  >XSS</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.487</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.387</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >HTMLDecorator4</td>
  <td  >no</td>
  <td  >XSS</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.446</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.43</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td rowspan=6   >Regain</td>
  <td  >ListTagSol0</td>
  <td  >yes</td>
  <td  >XSS</td>
  <td  >SAT</td>
  <td  align=right >29.550</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >24.675</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.19</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.361</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >ListTagSol1</td>
  <td  >yes</td>
  <td  >XSS</td>
  <td  >SAT</td>
  <td  align=right >24.980</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >27.015</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.21</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.308</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >ListTagSol2</td>
  <td  >yes</td>
  <td  >XSS</td>
  <td  >SAT</td>
  <td  align=right >25.890</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >24.716</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.18</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.299</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >FileServlet0</td>
  <td  >no</td>
  <td  >XSS</td>
  <td  >UNSAT</td>
  <td  align=right >2.084</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >2.573</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.01</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.17</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >FileServlet1</td>
  <td  >no</td>
  <td  >XSS</td>
  <td  >UNSAT</td>
  <td  align=right >2.157</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >2.521</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.01</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.167</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >FileServlet2</td>
  <td  >no</td>
  <td  >XSS</td>
  <td  >UNSAT</td>
  <td  align=right >2.051</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >2.617</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.01</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.166</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td rowspan=4   >PubSub</td>
  <td  >Subscriber0</td>
  <td  >no</td>
  <td  >XSS</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.134</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.192</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >Subscriber1</td>
  <td  >no</td>
  <td  >XSS</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.155</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.146</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >PuSHhandler0</td>
  <td  >yes</td>
  <td  >XML</td>
  <td  >FAIL</td>
  <td  align=right >9.830</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.321</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >0.987</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >PuSHhandler1</td>
  <td  >no</td>
  <td  >XML</td>
  <td  >FAIL</td>
  <td  align=right >3.500</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >UNSAT</td>
  <td  align=right >0.032</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >UNSAT</td>
  <td  align=right >0.018</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >rest-auth-proxy</td>
  <td  >LdapAuthService0</td>
  <td  >yes</td>
  <td  >LDAP</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >0.403</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >0.926</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td rowspan=12 >TPC-APP</td>
  <td  >ChangePaymentMethod_Vx0</td>
  <td  >no</td>
  <td  >SQL</td>
  <td  >UNSAT</td>
  <td  align=right >0.008</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.31</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.06</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.211</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >ChangePaymentMethod_VxA0</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.229</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.16</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.11</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >ChangePaymentMethod_VxA1</td>
  <td  >no</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.329</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.211</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >ChangePaymentMethod_VxA2</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.35</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.06</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.25</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >ChangePaymentMethod_VxA3</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.329</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.16</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.181</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >ChangePaymentMethod_VxA4</td>
  <td  >no</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.306</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.941</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >ChangePaymentMethod_VxA5</td>
  <td  >no</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.344</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.201</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >ChangePaymentMethod_VxA6</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.337</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.07</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.175</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >ProductDetails_Vx0</td>
  <td  >no</td>
  <td  >SQL</td>
  <td  >UNSAT</td>
  <td  align=right >0.007</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.308</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.014</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.151</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >ProductDetails_VxA0</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.56</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.015</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.434</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >NewProducts_Vx0</td>
  <td  >no</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >UNSAT</td>
  <td  align=right >0.416</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.016</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.178</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >NewProducts_VxA0</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >2.976</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.017</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.176</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td rowspan=34>TPC-C</td>
  <td  >Delivery_Vx0</td>
  <td  >no</td>
  <td  >SQL</td>
  <td  >UNSAT</td>
  <td  align=right >0.009</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.346</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.018</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.111</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >Delivery_VxA0</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >38.183</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.05</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.212</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >Delivery_VxA1</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >36.881</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.05</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.225</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >Delivery_VxA2</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >36.894</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.08</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.25</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >Delivery_VxA3</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >37.56</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.08</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.242</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >Delivery_VxA4</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >37.38</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.05</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.202</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >Delivery_VxA5</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >37.296</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.05</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.216</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >Delivery_VxA6</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >38.218</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.06</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.319</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >Delivery_VxA7</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >36.95</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.06</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.317</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >Delivery_VxA8</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >36.871</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.027</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.191</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >Delivery_VxA9</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >37.142</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.05</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.291</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >Delivery_VxA10</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >37.288</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.05</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.279</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OrderStatus_Vx0</td>
  <td  >no</td>
  <td  >SQL</td>
  <td  >UNSAT</td>
  <td  align=right >0.008</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.339</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.03</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.582</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OrderStatus_VxA0</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >3.943</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.031</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.271</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OrderStatus_VxA1</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >3.912</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.032</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.174</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OrderStatus_VxA2</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >4.338</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.033</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.18</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OrderStatus_VxA3</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >10.072</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.034</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.362</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OrderStatus_VxA4</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >9.008</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.035</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.428</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OrderStatus_VxA5</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.601</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.036</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.322</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OrderStatus_VxA6</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.118</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.037</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.186</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OrderStatus_VxA7</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >30.066</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.038</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.185</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OrderStatus_VxA8</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.701</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.039</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.186</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OrderStatus_VxA9</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.534</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.04</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.188</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OrderStatus_VxA10</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.55</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.041</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.182</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OrderStatus_VxA11</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.401</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.042</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.181</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >OrderStatus_VxA12</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.562</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.043</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.177</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td  >OrderStatus_VxA13</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >1.569</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.044</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.18</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td >OrderStatus_VxA14</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >2.9598</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.045</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.191</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td  >OrderStatus_Vx0</td>
  <td  >no</td>
  <td  >SQL</td>
  <td  >UNSAT</td>
  <td  align=right >0.076</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.317</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.046</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.198</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td  >StockLevel_VxA0</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >2.064</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.09</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.243</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td  >StockLevel_VxA1</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >2.065</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.08</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.246</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td  >StockLevel_VxA2</td>
  <td  >no</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >39.224</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  >FAIL</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >TIMEOUT</td>
  <td  align=right >39.231</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td >StockLevel_VxA3</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >3.982</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.03</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.188</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td  >StockLevel_VxA4</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >3.068</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.03</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.186</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td rowspan=6 >TPC-W</td>
  <td  >DoSubjectSearch_Vx0</td>
  <td  >no</td>
  <td  >SQL</td>
  <td  >UNSAT</td>
  <td  align=right >0.008</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.194</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.052</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.169</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td   >DoSubjectSearch_VxA0</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >0.587</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.053</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.212</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td  >DoAuthorSearch_Vx0</td>
  <td  >no</td>
  <td  >SQL</td>
  <td  >UNSAT</td>
  <td  align=right >0.007</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.12</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.054</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.177</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td  >DoAuthorSearch_VxA0</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >0.817</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.036</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.174</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td  >GetCustomer_Vx0</td>
  <td  >no</td>
  <td  >SQL</td>
  <td  >UNSAT</td>
  <td  align=right >0.009</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.133</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.056</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >UNSAT</td>
  <td  align=right >0.301</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td  >GetCustomer_VxA0</td>
  <td  >yes</td>
  <td  >SQL</td>
  <td  >FAIL</td>
  <td  align=right >0.000</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >1</td>
  <td  >SAT</td>
  <td  align=right >0.594</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.057</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  >SAT</td>
  <td  align=right >0.18</td>
  <td  align=right >1</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
  <td  align=right >0</td>
 </tr>
 <tr  >
  <td  colspan=4 ></td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td  >&nbsp;</td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td >&nbsp;</td>
  <td  >&nbsp;</td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td></td>
  <td >&nbsp;</td>
 </tr>
 <tr  >
  <td  ></td>
  <td >Sum</td>
  <td >&nbsp;</td>
  <td >&nbsp;</td>
  <td >&nbsp;</td>
  <td  align=right>100.281</td>
  <td  align=right>3</td>
  <td  align=right>40</td>
  <td  align=right>0</td>
  <td  align=right>61</td>
  <td  align=right>0</td>
  <td  align=right>85</td>
  <td  >
  <meta charset=utf-8>
  <span >&nbsp;</span></td>
  <td  align=right>1518.3278</td>
  <td  align=right>46</td>
  <td  align=right>40</td>
  <td  align=right>0</td>
  <td  align=right>18</td>
  <td  align=right>39</td>
  <td  align=right>0</td>
  <td  >
  <meta charset=utf-8>
  <span >&nbsp;</span></td>
  <td  align=right>4.956</td>
  <td  align=right>55</td>
  <td  align=right>40</td>
  <td  align=right>0</td>
  <td  align=right>9</td>
  <td  align=right>0</td>
  <td  align=right>32</td>
  <td  >
  <meta charset=utf-8>
  <span >&nbsp;</span></td>
  <td  align=right>728.569</td>
  <td  align=right>64</td>
  <td  align=right>40</td>
  <td  align=right>0</td>
  <td  align=right>0</td>
  <td  align=right>21</td>
  <td  align=right>0</td>
 </tr>
</table>



### The role of Sushi

To assess the role of Sushi in the second stage of our solving procedure, we ran both Z3-str2 and CVC4 together with a modified version of ACO-Solver where Sushi was switched-off, referred to as modACO-Solver.

When executed with 30s time-out, Z3-str2 + modACO-Solver timed-out on 85 cases with a recall of 4.7% and an overall execution time of 44 min. CVC4 + modACO-Solver timed out on 31 cases, with a recall of 87.5% and an overall execution time of 15.5 min and solved only one more case as compared to running CVC4 standalone.

For both solvers, increasing the timeout per test case to 300s did not result in
the detection of more vulnerable cases as compared to running them with a timeout of 30s. The
following table shows the results in detail:


* &Oslash;(timeout: 30s): Execution time of our test subjects with a timeout of 30s per attack condition
* &Oslash;(timeout: 300s) Execution time of our test subjects with a timeout of 300s per attack condition
* recall: the percentage of vulnerable cases detected from among the total vulnerable cases computed with tp/(tp + fn)*100

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
* Sushi 2.0: a Java archive may be requested from the main authors [here](http://people.hofstra.edu/Xiang_Fu/XiangFu/projects/SAFELI/SUSHI.php)
* Z3-str2: we used commit [2e52601](https://github.com/z3str/Z3-str/commit/2e52601). Installation instructions are available on the [github page](https://github.com/z3str/Z3-str).
* CVC4: for our experiments, we used [version 1.4.1](http://cvc4.cs.nyu.edu/builds/misc/cvc4-1.4.1-prerelease-2016-01-03.tar.gz). Installation instructions are available on the [CVC4 Wiki](http://cvc4.cs.nyu.edu/wiki/User_Manual).

The ACO-Solver tool may be downloaded
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

With regard to solving single attack conditions, the following two commands illustrate how CVC4 and Z3-str2 can be invoked directly:

```bash
cvc4 --lang smt XPATHInjection0.cvc4
```

```bash
./Z3-str.py -f ListTag0.z3str2
```
