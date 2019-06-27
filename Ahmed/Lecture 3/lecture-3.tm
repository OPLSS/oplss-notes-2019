<TeXmacs|1.99.2>

<style|<tuple|generic|number-long-article>>

<\body>
  <doc-data|<doc-title|Secure Compilation>|<doc-subtitle|Lecture
  3>|<doc-author|<author-data|<author-name|Dawn
  Michaelson>>>|<doc-author|<author-data|<author-name|Jake
  Errington>>>|<doc-author|<author-data|<author-name|Kuang-Chen
  Lu>>>|<doc-date|June 25, 2019>>

  This is the third talk presented by Amal Ahmed in OPLSS 2019, University of
  Oregon, USA.

  <section|Review>

  <\definition>
    Source Language<em|>

    <\eqnarray*>
      <tformat|<table|<row|<cell|\<sigma\>>|<cell|\<colons\>=>|<cell|int \ \|
      <around*|(|\<sigma\><rsub|1>,\<ldots\>,\<sigma\><rsub|n>|)>\<rightarrow\>\<sigma\>>>|<row|<cell|v>|<cell|\<colons\>=>|<cell|x
      \| n \| \<lambda\><around*|(|<wide|x:\<tau\>|\<bar\>>|)>.e>>|<row|<cell|e>|<cell|\<colons\>=>|<cell|v
      \| <with|font-series|bold|if0> v<rsub|> <with|font-series|bold|then>
      e<rsub|1> <with|font-series|bold|else> e<rsub|1> \|
      v<around*|(|<wide|v|\<bar\>>|)> \| <with|font-series|bold|let> x =
      e<rsub|1> <with|font-series|bold|in> e<rsub|2>>>>>
    </eqnarray*>
  </definition>

  <\definition>
    Target Language

    <\eqnarray*>
      <tformat|<table|<row|<cell|\<tau\>>|<cell|\<colons\>=>|<cell|int \ \|
      <around*|(|\<tau\><rsub|1>,\<ldots\>,\<tau\><rsub|n>|)>\<rightarrow\>\<tau\>
      \| <around*|\<langle\>|\<tau\><rsub|1>,\<ldots\>,\<tau\><rsub|n>|\<rangle\>>
      \| \<alpha\> \| \<exists\>\<alpha\>.\<tau\>>>|<row|<cell|v>|<cell|\<colons\>=>|<cell|x
      \| n \| \<lambda\><around*|(|<wide|x:\<tau\>|\<bar\>>|)>.e \|
      <around*|\<langle\>|v<rsub|1>,\<ldots\>v<rsub|n>|\<rangle\>> \|
      <with|font-series|bold|pack><around*|(|\<tau\>,v|)>
      <with|font-series|bold|as> \<exists\>\<alpha\>
      .\<tau\>>>|<row|<cell|e>|<cell|\<colons\>=>|<cell|v \|
      <with|font-series|bold|if0> v<rsub|> <with|font-series|bold|then>
      e<rsub|1> <with|font-series|bold|else> e<rsub|2> \|
      v<around*|(|<wide|v|\<bar\>>|)>\|v.1 \| v.2
      \|<with|font-series|bold|unpack><around*|(|\<alpha\>\<nocomma\>,x|)>=v
      <with|font-series|bold|in> e\| <with|font-series|bold|let> x =
      e<rsub|1> <with|font-series|bold|in> e<rsub|2>>>>>
    </eqnarray*>
  </definition>

  <\definition>
    Type Translation <math|\<sigma\><rsup|+>>

    <\eqnarray*>
      <tformat|<table|<row|<cell|<around*|(|int<rsub|S>|)><rsup|+>>|<cell|=>|<cell|int<rsub|T>>>|<row|<cell|<around*|(|\<sigma\><rsub|1>\<rightarrow\>\<sigma\><rsub|2>|)><rsup|+>>|<cell|=>|<cell|\<exists\>
      \<alpha\>\<nosymbol\>.<around*|\<langle\>| <around*|(|\<alpha\>
      ,\<sigma\><rsub|1><rsup|+>|)>\<rightarrow\>\<sigma\><rsub|2><rsup|+>\<nocomma\>,\<alpha\>|\<rangle\>>>>>>
    </eqnarray*>
  </definition>

  <\definition>
    Contextual Equivalence in Source Language
    <math|\<Gamma\>\<vdash\>e<rsub|1>\<approx\><rsup|ctx>e<rsub|2>
    :\<sigma\>>

    <\equation*>
      \<forall\> C:<around*|(|\<Gamma\>\<vdash\>\<tau\>|)>\<Rightarrow\><around*|(|\<cdummy\>
      \<vdash\>int|)>\<Longrightarrow\><around*|(|C<around*|[|e<rsub|1>|]>\<Downarrow\>v\<Longleftrightarrow\>C<around*|[|e<rsub|2>|]>\<Downarrow\>v|)>
    </equation*>
  </definition>

  <\definition>
    Contextual Equivalence in Target Language <math|
    \<Delta\>;\<Gamma\>\<vdash\>e<rsub|1>\<approx\><rsup|ctx>e<rsub|2>
    :\<tau\>>

    <\equation*>
      \<forall\> C:<around*|(|\<Delta\>;\<Gamma\>\<vdash\>\<tau\>|)>\<Rightarrow\><around*|(|\<cdummy\>
      ; \<cdummy\>\<vdash\>int|)>\<Longrightarrow\><around*|(|C<around*|[|e<rsub|1>|]>\<Downarrow\>v\<Longleftrightarrow\>C<around*|[|e<rsub|2>|]>\<Downarrow\>v|)>
    </equation*>
  </definition>

  When source language and target language come together, we distinguish them
  with subscripts <math|<rsub|S>> and <math|<rsub|T>>.

  <\definition>
    Compilation Judgement <math|\<Gamma\><rsub|S>\<vdash\>e<rsub|S>:\<sigma\>\<rightsquigarrow\>e<rsub|T>>
    (See the previous note for details)
  </definition>

  <section|Contextual Equivalence and CIU Equivalence>

  <\definition>
    CIU <math|\<triangleq\>> Uses of Closed Instantiation
  </definition>

  <\definition>
    CIU Equivalence in the source language
    <math|\<Gamma\>\<vdash\>e<rsub|1>\<approx\><rsup|ciu>e<rsub|2>:\<sigma\>>

    <\equation*>
      <with|math-condensed|false|\<forall\> E,\<matheuler\>\<nosymbol\>
      <with|font-series|bold| > \<Longrightarrow\>\<nosymbol\>
      <with|font-series|bold| > \ E : <around*|(| \<cdummy\>\<vdash\>
      \<sigma\> |)>\<Rightarrow\><around*|(| \<cdummy\>\<vdash\> int
      |)>\<nosymbol\> <with|font-series|bold| > \<wedge\>\<nosymbol\>
      <with|font-series|bold| > \<Gamma\>\<vdash\> \<matheuler\>\<nosymbol\>
      <with|font-series|bold| > \ \<Longrightarrow\>\<nosymbol\>
      <with|font-series|bold| > <around*|(| E <around*|[| \<matheuler\>
      <around*|(| e<rsub|1> |)> |]> \<Downarrow\> v\<nosymbol\>
      <with|font-series|bold| > \<Longleftrightarrow\>\<nosymbol\>
      <with|font-series|bold| > \ E <around*|[| \<matheuler\> <around*|(|
      e<rsub|2> |)> |]> \<Downarrow\> v |)>>
    </equation*>

    where <math|\<matheuler\>> is a substitution that includes all variables
    in <math|\<Gamma\>>
  </definition>

  <\definition>
    CIU Equivalence in target language <math|\<Delta\> ;
    \<Gamma\>\<vdash\>e<rsub|1>\<approx\><rsup|ciu>e<rsub|2>:\<tau\>>

    <\equation*>
      \<forall\> E,\<delta\>,\<matheuler\>\<nosymbol\>
      <with|font-series|bold| > \<Longrightarrow\> <with|font-series|bold| >
      E :<around*|(|\<cdot\> ;\<cdot\> \<vdash\>
      \<delta\><around*|(|\<tau\>|)>|)>\<Rightarrow\><around*|(|\<cdot\>
      \<vdash\>int|)> <with|font-series|bold| > \<wedge\>
      <with|font-series|bold| > \<delta\>\<vDash\>\<Delta\>
      <with|font-series|bold| > \<wedge\><with|font-series|bold| >
      \<delta\><around*|(|\<Gamma\>|)>\<vdash\>\<gamma\><with|font-series|bold|
      > \<Longrightarrow\><with|font-series|bold| > <around*|(|
      E<around*|[|\<delta\><around*|(|\<matheuler\><around*|(|e<rsub|1>|)>|)>|]>\<Downarrow\>v
      <with|font-series|bold| > \<Longleftrightarrow\>
      <with|font-series|bold| > E<around*|[|\<delta\><around*|(|\<matheuler\><around*|(|e<rsub|2>|)>|)>|]>\<Downarrow\>v
      |)>
    </equation*>

    where <math|\<matheuler\>> is a substitution that includes all variables
    in <math|\<Gamma\>>

    and <math|\<delta\>> is a substitution such that
    <math|dom<around*|(|\<delta\>|)>\<supseteq\>dom<around*|(|\<Delta\>|)>
    <with|font-series|bold| > \<wedge\> <with|font-series|bold| >
    <around*|(|\<forall\> \<alpha\>\<in\>\<Delta\>\<Longrightarrow\>\<cdummy\>\<vdash\>\<delta\><around*|(|\<alpha\>|)>|)>>
  </definition>

  <\theorem>
    CIU equivalence is equivalent to contextual equivalence in source
    language

    <\equation*>
      \<Gamma\>\<vdash\>e<rsub|1>\<approx\><rsup|ciu>e<rsub|2>:\<sigma\>
      \<Longleftrightarrow\> \<Gamma\>\<vdash\>e<rsub|1>\<approx\><rsup|ctx>e<rsub|2>
      :\<sigma\>
    </equation*>
  </theorem>

  <\theorem>
    CIU equivalence is equivalent to contextual equivalence in target
    language

    <\equation*>
      \<Delta\> ; \<Gamma\>\<vdash\>e<rsub|1>\<approx\><rsup|ciu>e<rsub|2>:\<tau\>
      \<Longleftrightarrow\> \ \<Delta\>;\<Gamma\>\<vdash\>e<rsub|1>\<approx\><rsup|ctx>e<rsub|2>
      :\<tau\>
    </equation*>
  </theorem>

  <section|Back-translation>

  <\definition>
    Back-translation Judgement <math|\<cdummy\> ; \<Gamma\><rsub|S><rsup|+>
    \<vdash\> e<rsub|T> : \<sigma\><rsup|+> \<twoheadrightarrow\> e<rsub|S>>,
    where <math|\<Gamma\><rsub|S>\<vdash\>e<rsub|S> :\<sigma\>>

    <block*|<tformat|<cwith|1|1|1|1|cell-halign|c>|<cwith|2|2|1|1|cell-halign|c>|<cwith|2|2|1|1|cell-lborder|1>|<cwith|2|2|1|1|cell-rborder|1>|<cwith|2|2|1|1|cell-bborder|1>|<cwith|1|1|1|1|cell-lborder|10>|<cwith|1|1|1|1|cell-rborder|10>|<cwith|1|1|1|1|cell-bborder|10>|<cwith|1|1|1|1|cell-tborder|10>|<cwith|2|2|1|1|cell-tborder|1px>|<table|<row|<cell|<math|\<cdummy\>
    ; \<Gamma\><rsub|S><rsup|+>\<vdash\>x<rsub|T>
    :\<sigma\><rsup|+>>>>|<row|<cell|<math|><math|\<cdummy\> ;
    \<Gamma\><rsub|S><rsup|+> \<vdash\> x<rsub|T> : \<sigma\><rsup|+>
    \<twoheadrightarrow\> x<rsub|S>>>>>>> variable

    \;

    <block*|<tformat|<cwith|1|1|1|1|cell-halign|c>|<cwith|2|2|1|1|cell-halign|c>|<cwith|2|2|1|1|cell-lborder|1>|<cwith|2|2|1|1|cell-rborder|1>|<cwith|2|2|1|1|cell-bborder|1>|<cwith|1|1|1|1|cell-lborder|10>|<cwith|1|1|1|1|cell-rborder|10>|<cwith|1|1|1|1|cell-bborder|10>|<cwith|1|1|1|1|cell-tborder|10>|<cwith|2|2|1|1|cell-tborder|1px>|<table|<row|<cell|<math|\<cdummy\>
    ; \<Gamma\><rsub|S><rsup|+>\<vdash\>n<rsub|T>
    :int<rsub|T>>>>|<row|<cell|<math|><math|\<cdummy\> ;
    \<Gamma\><rsub|S><rsup|+> \<vdash\> n<rsub|T> : int<rsub|T>
    \<twoheadrightarrow\> int<rsub|S>>>>>>> number

    \;

    <block*|<tformat|<cwith|3|3|1|1|cell-halign|c>|<cwith|4|4|1|1|cell-halign|c>|<cwith|4|4|1|1|cell-lborder|1>|<cwith|4|4|1|1|cell-rborder|1>|<cwith|4|4|1|1|cell-bborder|1>|<cwith|3|3|1|1|cell-lborder|10>|<cwith|3|3|1|1|cell-rborder|10>|<cwith|3|3|1|1|cell-bborder|10>|<cwith|3|3|1|1|cell-tborder|10>|<cwith|4|4|1|1|cell-tborder|1px>|<cwith|1|3|1|1|cell-lborder|0>|<cwith|1|3|1|1|cell-rborder|0>|<cwith|1|3|1|1|cell-bborder|0>|<cwith|1|3|1|1|cell-tborder|0>|<table|<row|<cell|\<cdummy\>;\<Gamma\><rsub|S><rsup|+>\<vdash\>v:<around*|\<langle\>|<around*|(|\<tau\><rsub|env>,\<sigma\><rsub|1><rsup|+>|)>\<rightarrow\>\<sigma\><rsub|2><rsup|+>,\<tau\><rsub|env>|\<rangle\>>>>|<row|<cell|thus
    <math|v=<around*|\<langle\>|v<rsub|f>\<nocomma\>,v<rsub|env>|\<rangle\>>>
    and <math|v<rsub|f>=\<lambda\> <around*|(|z : \<tau\><rsub|env>
    \<nocomma\>\<nocomma\>,x<rsub|T> :\<sigma\><rsub|1><rsup|+>|)>\<nosymbol\>.e<rsub|T>>
    and <math|\<cdummy\> ; \<Gamma\><rsub|S><rsup|+>\<vdash\> v<rsub|env>
    :\<tau\><rsub|env>>>>|<row|<cell|<math|\<cdummy\> ; x<rsub|T> :
    \<sigma\><rsub|1><rsup|+> \<vdash\>e<rsub|T>
    <around*|[|v<rsub|env>/z|]>:\<sigma\><rsub|2><rsup|+>\<twoheadrightarrow\>e<rsub|s>>>>|<row|<cell|<math|><math|\<cdummy\>
    ; \<Gamma\><rsub|S><rsup|+> \<vdash\>
    <with|font-series|bold|pack><around*|(|\<tau\><rsub|env>,v|)>
    <with|font-series|bold|as> \<ldots\> :
    \<exists\>\<alpha\>\<nosymbol\>\<nosymbol\>.<around*|\<langle\>|<around*|(|\<alpha\>,\<sigma\><rsub|1><rsup|+>|)>\<rightarrow\>\<sigma\><rsub|2><rsup|+>,
    \<alpha\>|\<rangle\>> \<twoheadrightarrow\> \<lambda\> x<rsub|S> :
    \<sigma\><rsub|1> . e<rsub|S>>>>>>> closure

    \;

    <block*|<tformat|<cwith|2|2|1|1|cell-halign|c>|<cwith|4|4|1|1|cell-halign|c>|<cwith|4|4|1|1|cell-lborder|1>|<cwith|4|4|1|1|cell-rborder|1>|<cwith|4|4|1|1|cell-bborder|1>|<cwith|4|4|1|1|cell-tborder|1px>|<cwith|1|3|1|1|cell-lborder|0>|<cwith|1|3|1|1|cell-rborder|0>|<cwith|1|3|1|1|cell-bborder|0>|<cwith|1|3|1|1|cell-tborder|0>|<table|<row|<cell|<math|\<cdummy\>
    ; \<Gamma\><rsub|S><rsup|+>\<vdash\>v<rsub|T<rsub|>>
    :int<rsub|T>\<twoheadrightarrow\>v<rsub|S>>>>|<row|<cell|<math|\<cdummy\>
    ; \<Gamma\><rsub|S><rsup|+>\<vdash\>e<rsub|T<rsub|>1>
    :\<sigma\><rsup|+>\<twoheadrightarrow\>e<rsub|S1>>>>|<row|<cell|<math|\<cdummy\>
    ; \<Gamma\><rsub|S><rsup|+>\<vdash\>e<rsub|T<rsub|>2>
    :\<sigma\><rsup|+>\<twoheadrightarrow\>e<rsub|S2>>>>|<row|<cell|<math|><math|\<cdummy\>
    ; \<Gamma\><rsub|S><rsup|+> \<vdash\> <with|font-series|bold|if0>
    v<rsub|T> <with|font-series|bold|then> e<rsub|T1>
    <with|font-series|bold|else> e<rsub|T2>: \<sigma\><rsup|+>
    \<twoheadrightarrow\> <with|font-series|bold|if0> v<rsub|S>
    <with|font-series|bold|then> e<rsub|S1> <with|font-series|bold|else>
    e<rsub|S2>>>>>>>if0

    \;

    <tabular|<tformat|<cwith|4|4|1|1|cell-lborder|1>|<cwith|4|4|1|1|cell-rborder|1>|<cwith|4|4|1|1|cell-bborder|1>|<cwith|4|4|1|1|cell-tborder|1px>|<cwith|1|3|1|1|cell-lborder|0>|<cwith|1|3|1|1|cell-rborder|0>|<cwith|1|3|1|1|cell-bborder|0>|<cwith|1|3|1|1|cell-tborder|0>|<cwith|1|-1|1|1|cell-halign|c>|<table|<row|<cell|<math|\<cdummy\>
    ; \<Gamma\><rsub|S><rsup|+>\<vdash\><rsub|<rsub|>> v<rsub|f>:
    <around*|(|\<tau\><rsub|1>,\<ldots\>,\<tau\><rsub|n>|)>\<rightarrow\>\<sigma\><rsup|+>>>>|<row|<cell|<math|v<rsub|f>=\<lambda\>
    <around*|(|x<rsub|1>:\<tau\><rsub|1>,\<ldots\>,x<rsub|n>:\<tau\><rsub|n>|)>\<nosymbol\>.e<rsub|T>>>>|<row|<cell|<math|\<cdummy\>
    ;\<Gamma\><rsub|S><rsup|+>\<vdash\>e<rsub|T><around*|[|v<rsub|1>/x<rsub|1>|]>\<ldots\><around*|[|v<rsub|n>/x<rsub|n>|]>:\<sigma\><rsup|+>\<twoheadrightarrow\>e<rsub|S>>>>|<row|<cell|<math|><math|\<cdummy\>
    ; \<Gamma\><rsub|S><rsup|+> \<vdash\>
    v<rsub|f><around*|(|v<rsub|1>,\<ldots\>,v<rsub|n>|)>:\<sigma\><rsup|+>\<twoheadrightarrow\>e<rsub|S>>>>>>>application

    \;

    <tabular|<tformat|<cwith|4|4|1|1|cell-lborder|1>|<cwith|4|4|1|1|cell-rborder|1>|<cwith|4|4|1|1|cell-bborder|1>|<cwith|4|4|1|1|cell-tborder|1px>|<cwith|1|2|1|1|cell-lborder|0>|<cwith|1|2|1|1|cell-rborder|0>|<cwith|1|2|1|1|cell-bborder|0>|<cwith|1|2|1|1|cell-tborder|0>|<cwith|1|4|1|1|cell-halign|c>|<table|<row|<cell|<math|\<cdummy\>
    ; \<Gamma\><rsub|S><rsup|+>\<vdash\><rsub|<rsub|>> v :
    <around*|\<langle\>|\<tau\><rsub|1>,\<ldots\>,\<tau\><rsub|n>|\<rangle\>>>
    \ <math|v=<around*|\<langle\>|v<rsub|1>,\<ldots\>,v<rsub|n>|\<rangle\>>>>>|<row|<cell|<math|1\<leqslant\>i\<leqslant\>n>>>|<row|<cell|<math|\<cdummy\>;\<Gamma\><rsub|S><rsup|+>\<vdash\>v<rsub|i>:\<sigma\><rsub|1><rsup|+>\<twoheadrightarrow\>v<rsub|S
    i>>>>|<row|<cell|<math|><math|\<cdummy\> ; \<Gamma\><rsub|S><rsup|+>
    \<vdash\> v.i:\<sigma\><rsup|+>\<twoheadrightarrow\>v<rsub|S
    i>>>>>>>projection

    \;

    <tabular|<tformat|<cwith|3|3|1|1|cell-lborder|1>|<cwith|3|3|1|1|cell-rborder|1>|<cwith|3|3|1|1|cell-bborder|1>|<cwith|3|3|1|1|cell-tborder|1px>|<cwith|1|3|1|1|cell-halign|c>|<table|<row|<cell|<math|\<cdummy\>
    ;\<Gamma\><rsub|S><rsup|+>\<vdash\>e<rsub|T1> :
    \<sigma\><rsub|1><rsup|+>\<twoheadrightarrow\>e<rsub|S1>>Yeah!>>|<row|<cell|<math|\<cdummy\>;\<Gamma\><rsub|S><rsup|+>,x<rsub|T>
    : \<sigma\><rsub|1><rsup|+>\<vdash\>e<rsub|T2> :
    \<sigma\><rsub|2><rsup|+>\<twoheadrightarrow\>e<rsub|S
    2>>>>|<row|<cell|<math|\<cdummy\> ; \<Gamma\><rsub|S><rsup|+>\<vdash\><with|font-series|bold|let>
    x<rsub|T>=e<rsub|T1><with|font-series|bold| in>
    e<rsub|T2>:\<sigma\><rsub|2><rsup|+>\<twoheadrightarrow\><with|font-series|bold|let>
    x<rsub|S>=e<rsub|S1> <with|font-series|bold|in> e<rsub|S2>>>>>>>let

    \;

    <tabular|<tformat|<cwith|5|5|1|1|cell-lborder|1>|<cwith|5|5|1|1|cell-rborder|1>|<cwith|5|5|1|1|cell-bborder|1>|<cwith|5|5|1|1|cell-tborder|1px>|<cwith|1|-1|1|1|cell-halign|c>|<table|<row|<cell|<math|v<rsub|T>>
    is not a variable>>|<row|<cell|<math|\<cdummy\>
    ;\<Gamma\><rsub|S><rsup|+>\<vdash\>v<rsub|T> : \<exists\>
    \<alpha\>\<nosymbol\>.\<tau\>>>>|<row|<cell|<math|v<rsub|T>=<with|font-series|bold|pack><around*|(|\<tau\><rprime|'>,v<rprime|'>|)>>>>|<row|<cell|<math|\<cdummy\>;\<Gamma\><rsub|S><rsup|+>\<vdash\>e<rsub|T><around*|[|\<tau\><rprime|'>/\<alpha\>|]><around*|[|v<rprime|'>/x<rsub|T>|]>
    : \<sigma\><rsup|+>\<twoheadrightarrow\>e<rsub|S
    >>>>|<row|<cell|<math|\<cdummy\> ; \<Gamma\><rsub|S><rsup|+>\<vdash\><with|font-series|bold|unpack><around*|(|\<alpha\>
    ,x<rsub|T>|)>=v<rsub|T> <with|font-series|bold|in> e<rsub|T> :
    \<sigma\><rsup|+> \<twoheadrightarrow\> e<rsub|S>>>>>>>unpack
  </definition>

  <\theorem>
    Back-translation is well-founded

    <\equation*>
      \<cdummy\> ; \<Gamma\><rsub|S><rsup|+> \<vdash\> e<rsub|T> :
      \<sigma\><rsup|+> \<Longrightarrow\> \<exists\> e<rsub|S>
      \<nosymbol\>\<nosymbol\>\<nosymbol\>.\<cdummy\> ;
      \<Gamma\><rsub|S><rsup|+> \<vdash\> e<rsub|T> :
      \<sigma\><rsup|+>\<twoheadrightarrow\>e<rsub|S>
    </equation*>
  </theorem>

  <\theorem>
    Back-translation preserves semantics

    <\equation*>
      \<cdummy\> ; \<Gamma\><rsub|S><rsup|+> \<vdash\> e<rsub|T> :
      \<sigma\><rsup|+>\<twoheadrightarrow\>e<rsub|S> \<Longrightarrow\>
      \<Gamma\><rsub|S>\<vdash\> e<rsub|S>\<simeq\>e<rsub|T>:\<sigma\>
    </equation*>
  </theorem>

  <section|Connecting Everything ...>

  <\theorem>
    Equivalence Preservation

    If <math|\<Gamma\><rsub|S>\<vdash\>e<rsub|S1>
    :\<sigma\>\<rightsquigarrow\>e<rsub|T1>> and
    <math|\<Gamma\><rsub|S>\<vdash\>e<rsub|S2>
    :\<sigma\>\<rightsquigarrow\>e<rsub|T2>>, then
    <math|\<Gamma\><rsub|S>\<vdash\> e<rsub|S1>\<approx\><rsub|S><rsup|ctx>e<rsub|S2>
    :\<sigma\> \<Longrightarrow\>\<Gamma\><rsub|S><rsup|+>\<vdash\>e<rsub|T1>\<approx\><rsup|ctx><rsub|T>e<rsub|T2>
    : \<sigma\><rsup|+>>

    <\proof>
      \;

      As CIU equivalence is equivalent to contextual equivalent in our
      languages, we replace <math|ctx> with <math|ciu> in our goal.

      Assume arbitrary <math|E<rsub|T> : <around*|(|\<cdummy\> ; \<cdummy\>
      \<vdash\> \<sigma\><rsup|+>|)>\<Rightarrow\><around*|(|\<cdummy\> ;
      \<nosymbol\>\<cdummy\> \<vdash\> int<rsub|T>|)> <with|font-series|bold|
      > \<wedge\> <with|font-series|bold| >
      \<Gamma\><rsub|S><rsup|+>\<vdash\>\<gamma\><rsub|T>>

      Without loss of generality, assume <math|E<rsub|T><around*|[|\<matheuler\><rsub|T><around*|(|e<rsub|T1>|)>|]>\<Downarrow\>n\<nosymbol\>>
      and show <math|E<rsub|T><around*|[|\<matheuler\><rsub|T><around*|(|e<rsub|T2>|)>|]>\<Downarrow\>n>.

      If we can show for all <math|E<rsub|T>> there exists an equivalent
      <math|E<rsub|S>>, we can move clockwise from the bottom-left corner to
      the bottom-right corner in the following figure, i.e., prove the
      theorem.

      <\equation*>
        <tabular|<tformat|<cwith|2|2|1|1|cell-halign|c>|<cwith|2|2|3|3|cell-halign|c>|<table|<row|<cell|E<rsub|S><around*|[|\<matheuler\><rsub|S><around*|(|e<rsub|S1>|)>|]>\<Downarrow\>n<rsub|S>>|<cell|\<approx\><rsup|ctx><rsub|S>>|<cell|E<rsub|S><around*|[|\<matheuler\><rsub|S><around*|(|e<rsub|S2>|)>|]>\<Downarrow\>n<rsub|S>>>|<row|<cell|\<Longuparrow\>>|<cell|>|<cell|\<Longdownarrow\>>>|<row|<cell|E<rsub|T><around*|[|\<matheuler\><rsub|T><around*|(|e<rsub|T1>|)>|]>\<Downarrow\>n<rsub|T>>|<cell|\<approx\><rsup|ctx><rsub|T>>|<cell|E<rsub|T><around*|[|\<matheuler\><rsub|T><around*|(|e<rsub|T2>|)>|]>\<Downarrow\>n<rsub|T>>>>>>
      </equation*>

      Actually, we can show such <math|E<rsub|S>> exists, with the help of
      back-translation:

      Firstly a evaluation context can be read as a lambda
      <math|E<rsub|T><around*|[|e|]>\<equiv\><around*|(|\<lambda\> x :
      \<sigma\><rsup|+>. E<around*|[|x|]>|)> e>.

      And we know the lambda is of type <math|\<cdummy\>;
      \<cdummy\>\<vdash\>\<sigma\><rsup|+>\<Rightarrow\> int<rsub|T>>.

      Thus we can back-translate <math|\<cdummy\>
      ;x:\<sigma\><rsup|+>\<vdash\>E<around*|[|x|]>:int<rsub|T>>
    </proof>
  </theorem>

  <section|Future Readings>

  <\itemize>
    <item>Bowman, William J., and Amal Ahmed. ``Noninterference for free.''
    <with|font-shape|italic|ACM SIGPLAN Notices> 50.9 (2015): 101-113.

    <item>New, Max S., William J. Bowman, and Amal Ahmed. ``Fully abstract
    compilation via universal embedding.'' <with|font-shape|italic|ACM
    SIGPLAN Notices>. Vol. 51. No. 9. ACM, 2016.

    <item>Devriese, Dominique, Marco Patrignani, and Frank Piessens.
    ``Fully-abstract compilation by approximate back-translation.''
    <with|font-shape|italic|ACM SIGPLAN Notices>. Vol. 51. No. 1. ACM, 2016.

    <item>Patrignani, Marco, et al. ``Secure compilation to protected module
    architectures.'' <with|font-shape|italic|ACM Transactions on Programming
    Languages and Systems (TOPLAS)> 37.2 (2015): 6.
  </itemize>
</body>

<\initial>
  <\collection>
    <associate|page-type|letter>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-2|<tuple|2|1>>
    <associate|auto-3|<tuple|3|2>>
    <associate|auto-4|<tuple|4|3>>
    <associate|auto-5|<tuple|5|3>>
    <associate|footnote-1|<tuple|1|?>>
    <associate|footnote-2|<tuple|2|?>>
    <associate|footnr-1|<tuple|1|?>>
    <associate|footnr-2|<tuple|2|?>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Review>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Contextual
      Equivalence and CIU Equivalence> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>Back-translation>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|4<space|2spc>Connecting
      Everything ...> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|5<space|2spc>Future
      Readings> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>