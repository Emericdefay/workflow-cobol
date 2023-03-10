<p align="center">
  <a href="" rel="noopener">
 <img width=200px height=200px src="./com/cobol.png" alt="Cobol logo"></a>
</p>

<h3 align="center">Proof of Concept : Workflow COBOL</h3>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![GitHub Issues](https://img.shields.io/github/issues/Emericdefay/workflow-cobol.svg)](https://github.com/Emericdefay/workflow-cobol/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/Emericdefay/workflow-cobol.svg)](https://github.com/Emericdefay/workflow-cobol/pulls)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

</div>

---

<p align="center"> Implementation of COBOL tests in github workflow
    <br> 
</p>

## 📝 Table of Contents

- [📝 Table of Contents](#-table-of-contents)
- [🧐 About ](#-about-)
- [🎈 Usage ](#-usage-)
- [✍️ Authors ](#️-authors-)

## 🧐 About <a name = "about"></a>

The purpose of this repository is to propose a workflow github with cobol.
  
The main issue is about CICS and DB2.  
Indeed, the precompilation of CICS and DB2 require IBM's tools that are not available using github actions.
  
I propose a "solution" if you want to test easy functionnalities using SQLITE instead of DB2.  

You can see the method, using SQLITE inside TEST-SUM, that getting numbers from the database.

BUT, using this method restrains your tests' field to unit testing of simple modules or functionnal testing without using CICS or DB2.

## 🎈 Usage <a name="usage"></a>

1. Adapte ```SUM.cob``` ```TEST-SUM.cob``` To your programs
2. Adapte ````SQL.txt``` if you need data
3. Adapte ```.github/Workflow/test.yml``` To run your tests

## ✍️ Authors <a name = "authors"></a>

- [@Emericdefay](https://github.com/Emericdefay) - Idea & Initial work
