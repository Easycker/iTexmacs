<TeXmacs|1.0.7.11>

<style|<tuple|tmdoc|octave>>

<\body>
  <tmdoc-title|Further details on the <name|Octave> plug-in>

  <name|Octave> and <TeXmacs> communicate via a synchronous pipe interface.
  This allows the <name|Octave> console to be presented in a typeset region
  of a <TeXmacs> document. To display typeset materials in this <TeXmacs>
  region, <name|Octave> code can print escape sequences to transfer
  <name|Scheme>, <LaTeX>, or Postscript materials for display.\ 

  This <name|Octave> interface is implmeneted a a set of m-files for
  interacting with <TeXmacs> via <name|Scheme>. As of v1.0.1 <TeXmacs>
  includes the required interface code and should automagically detect the
  presense of <name|Octave>. These m-files generate <TeXmacs> content from
  <name|Octave> and perform related functions:

  <\indent>
    <with|color|blue|tmdisp.m> \ Displays an <name|Octave> variable
    "pretty-printed" via the <TeXmacs> interface. It supports scalar, matrix,
    structure, list and string types. You must use tmdisp, instead of disp,
    to get \ <TeXmacs> formatted variable output.

    <with|color|blue|mesh.m> \ Modified mesh routine for use with <TeXmacs>.
    Also included are modified back-end plot routines using gnuplot to
    transfer the embedded Postscript to <TeXmacs>. High level interfaces like
    plot work as expected.

    <with|color|blue|polyout.m> \ Modified polynomial printer to use a
    <LaTeX> formula.

    <with|color|blue|scheme.m> \ Executes a string as a <name|Scheme>
    expression via <TeXmacs>.

    <with|color|blue|num2scm.m> Converts a number (scalar) to a <TeXmacs>
    <name|Scheme> expression.

    <with|color|blue|mat2scm.m> \ Converts a matrix to a <TeXmacs>
    <name|Scheme> expression.

    <with|color|blue|str2scm.m> \ Converts a string to a <TeXmacs>
    <name|Scheme> expression.

    <with|color|blue|struct2bullet.m> Converts a structure to a bulleted
    <TeXmacs> list.

    <with|color|blue|struct2tree.m> \ Converts a structure to a <TeXmacs>
    tree. The leaves of the tree are "switchable" and can be switched to the
    variable name or content for easy traversal of complicated <name|Octave>
    structures.\ 

    <with|color|blue|struct2scm.m> Converts a structure to a <TeXmacs>
    <name|Scheme> expression by calling either struct2bullet or struct2tree,
    depending on the user's configuration. The TMSTRUCT global <name|Octave>
    variable is used. If TMSTRUCT = 0 a tree is used, else a bulleted list is
    used.

    <with|color|blue|list2scm.m> \ Converts a list to a <TeXmacs>
    <name|Scheme> expression.\ 

    <with|color|blue|obj2scm.m> Front end interface to the other converters
    to convert an arbitrary <name|Octave> variable to a <TeXmacs>
    <name|Scheme> expression. In most cases, user programs should use this
    function.
  </indent>

  The appearance of the <TeXmacs> output, namely the colors used, can be
  customized by setting the appropriate <name|Octave> global variables. These
  global variables should be defined in your ~/.octaverc or in the
  system-wide octaverc:

  <\indent>
    <\code>
      <\with|par-par-sep|0fn>
        global TMSTRUCT=0; ## Use tree output for structures.

        global TMCOLORS=["black"; "red"; "magenta"; "orange"; "green";
        "blue";];

        global TMCOLIDX=6; ## number of colors
      </with>
    </code>
  </indent>

  The TMCOLORS array lists the available colors, in order, to be used by
  struct2bullet.m it will change to each color in turn as it indents the
  bulleted list. Additionally, the first color in the list is used as the
  color for the leaves of struct2tree.m output.\ 

  As an example of using these functions and of their behavior, consider the
  following sample <name|Octave> session:

  <\session|octave|default>
    <\output>
      GNU Octave, version 2.1.36 (i686-pc-linux-gnu).

      Copyright (C) 1996, 1997, 1998, 1999, 2000, 2001, 2002 John W. Eaton.

      This is free software; see the source code for copying conditions.

      There is ABSOLUTELY NO WARRANTY; not even for MERCHANTIBILITY or

      FITNESS FOR A PARTICULAR PURPOSE.

      \;

      Report bugs to \<less\>bug-octave@bevo.che.wisc.edu\<gtr\>.

      \;
    </output>

    <\input-math|octave\<gtr\> >
      <with|color|blue|M.mat=<matrix|<tformat|<table|<row|<cell|1>|<cell|3>|<cell|5>>|<row|<cell|5>|<cell|8>|<cell|0>>>>>;
      \ M.l=list<around|(|<around|[|1,2,3|]>,2,3|)>; M.branch.i=3;
      M.branch.j=4;>
    </input-math>

    <\unfolded-io-math|octave\<gtr\> >
      <with|color|blue|tmdisp<around|(|M|)>;> <with|color|black|## M.mat has
      been <rprime|''>switched<rprime|''>>
    <|unfolded-io-math>
      <tree|<with|color|red|<math|<big|triangleup>>>|<switch|<\hidden>
        <with|color|red|mat>
      </hidden>|<with|color|yellow|<math|<with|math-display|true|<with|color|blue|<matrix|<tformat|<table|<row|<cell|1>|<cell|3>|<cell|5>>|<row|<cell|5>|<cell|8>|<cell|0>>>>>>>>>>|<\switch>
        <with|color|red|l>
      </switch|<hidden|<with|color|yellow|<\enumerate-numeric>
        <item><math|<with|math-display|true|<matrix|<tformat|<table|<row|<cell|1>|<cell|2>|<cell|3>>>>>>>

        <item><math|2>

        <item><math|3>
      </enumerate-numeric>>>>|<tree|<with|color|red|branch>|<\switch>
        <with|color|red|i>
      </switch|<hidden|<with|color|yellow|<math|3>>>>|<\switch>
        <with|color|red|j>
      </switch|<hidden|<with|color|yellow|<math|4>>>>>>

      \;
    </unfolded-io-math>

    <\input-math|octave\<gtr\> >
      <with|color|blue|TMSTRUCT=1;>
    </input-math>

    <\unfolded-io-math|octave\<gtr\> >
      <with|color|blue|tmdisp<around|(|M|)>>
    <|unfolded-io-math>
      <\itemize-arrow>
        <item><with|color|red|mat = ><math|<with|math-display|true|<matrix|<tformat|<table|<row|<cell|1>|<cell|3>|<cell|5>>|<row|<cell|5>|<cell|8>|<cell|0>>>>>>>

        <item><with|color|red|l = ><\enumerate-numeric>
          <item><math|<with|math-display|true|<matrix|<tformat|<table|<row|<cell|1>|<cell|2>|<cell|3>>>>>>>

          <item><math|2>

          <item><math|3>
        </enumerate-numeric>

        <item><with|color|red|branch = ><\itemize>
          <item><with|color|black|i = ><math|3>

          <item><with|color|black|j = ><math|4>
        </itemize>
      </itemize-arrow>

      \;
    </unfolded-io-math>

    <\unfolded-io-math|octave\<gtr\> >
      <with|color|blue|tmpolyout<around|(|<around|[|4,5,6|]>|)>>
    <|unfolded-io-math>
      <\math>
        4\<cdot\>s<rsup|2>+5\<cdot\>s<rsup|1>+6
      </math>

      \;
    </unfolded-io-math>

    <\input|octave\<gtr\> >
      X=0:.1:3;
    </input>

    <\input|octave\<gtr\> >
      Y=sin(X);
    </input>

    <\unfolded-io|octave\<gtr\> >
      plot(X,Y);
    <|unfolded-io>
      \;

      \;

      <image|<tuple|<#252150532D41646F62652D322E3020455053462D322E300A25255469746C653A202F746D702F746D706C6F742E6570730A252543726561746F723A20676E75706C6F7420332E372070617463686C6576656C20320A25254372656174696F6E446174653A20547565204D61792032302031333A30303A353120323030330A2525446F63756D656E74466F6E74733A20286174656E64290A2525426F756E64696E67426F783A20353020353020323330203137360A25254F7269656E746174696F6E3A20506F7274726169740A2525456E64436F6D6D656E74730A2F676E7564696374203235362064696374206465660A676E756469637420626567696E0A2F436F6C6F722074727565206465660A2F536F6C69642066616C7365206465660A2F676E756C696E65776964746820352E303030206465660A2F757365726C696E65776964746820676E756C696E657769647468206465660A2F767368696674202D3436206465660A2F646C207B3130206D756C7D206465660A2F6870745F2033312E35206465660A2F7670745F2033312E35206465660A2F687074206870745F206465660A2F767074207670745F206465660A2F4D207B6D6F7665746F7D2062696E64206465660A2F4C207B6C696E65746F7D2062696E64206465660A2F52207B726D6F7665746F7D2062696E64206465660A2F56207B726C696E65746F7D2062696E64206465660A2F76707432207670742032206D756C206465660A2F68707432206870742032206D756C206465660A2F4C73686F77207B2063757272656E74706F696E74207374726F6B65204D0A2020302076736869667420522073686F77207D206465660A2F5273686F77207B2063757272656E74706F696E74207374726F6B65204D0A202064757020737472696E67776964746820706F70206E65672076736869667420522073686F77207D206465660A2F4373686F77207B2063757272656E74706F696E74207374726F6B65204D0A202064757020737472696E67776964746820706F70202D32206469762076736869667420522073686F77207D206465660A2F5550207B20647570207670745F206D756C202F767074206578636820646566206870745F206D756C202F6870742065786368206465660A20202F68707432206870742032206D756C20646566202F76707432207670742032206D756C20646566207D206465660A2F444C207B20436F6C6F72207B736574726762636F6C6F7220536F6C6964207B706F70205B5D7D20696620302073657464617368207D0A207B706F7020706F7020706F7020536F6C6964207B706F70205B5D7D206966203020736574646173687D206966656C7365207D206465660A2F424C207B207374726F6B6520757365726C696E6577696474682032206D756C207365746C696E657769647468207D206465660A2F414C207B207374726F6B6520757365726C696E657769647468203220646976207365746C696E657769647468207D206465660A2F554C207B2064757020676E756C696E657769647468206D756C202F757365726C696E6577696474682065786368206465660A2020202020206475702031206C74207B706F7020317D206966203130206D756C202F75646C206578636820646566207D206465660A2F504C207B207374726F6B6520757365726C696E657769647468207365746C696E657769647468207D206465660A2F4C5462207B20424C205B5D20302030203020444C207D206465660A2F4C5461207B20414C205B312075646C206D756C20322075646C206D756C5D2030207365746461736820302030203020736574726762636F6C6F72207D206465660A2F4C5430207B20504C205B5D20312030203020444C207D206465660A2F4C5431207B20504C205B3420646C203220646C5D20302031203020444C207D206465660A2F4C5432207B20504C205B3220646C203320646C5D20302030203120444C207D206465660A2F4C5433207B20504C205B3120646C20312E3520646C5D20312030203120444C207D206465660A2F4C5434207B20504C205B3520646C203220646C203120646C203220646C5D20302031203120444C207D206465660A2F4C5435207B20504C205B3420646C203320646C203120646C203320646C5D20312031203020444C207D206465660A2F4C5436207B20504C205B3220646C203220646C203220646C203420646C5D20302030203020444C207D206465660A2F4C5437207B20504C205B3220646C203220646C203220646C203220646C203220646C203420646C5D203120302E33203020444C207D206465660A2F4C5438207B20504C205B3220646C203220646C203220646C203220646C203220646C203220646C203220646C203420646C5D20302E3520302E3520302E3520444C207D206465660A2F506E74207B207374726F6B65205B5D203020736574646173680A20202067736176652031207365746C696E65636170204D203020302056207374726F6B652067726573746F7265207D206465660A2F446961207B207374726F6B65205B5D20302073657464617368203220636F70792076707420616464204D0A2020687074206E656720767074206E656720562068707420767074206E656720560A202068707420767074205620687074206E656720767074205620636C6F736570617468207374726F6B650A2020506E74207D206465660A2F506C73207B207374726F6B65205B5D203020736574646173682076707420737562204D2030207670743220560A202063757272656E74706F696E74207374726F6B65204D0A2020687074206E656720767074206E65672052206870743220302056207374726F6B650A20207D206465660A2F426F78207B207374726F6B65205B5D20302073657464617368203220636F70792065786368206870742073756220657863682076707420616464204D0A2020302076707432206E656720562068707432203020562030207670743220560A202068707432206E65672030205620636C6F736570617468207374726F6B650A2020506E74207D206465660A2F437273207B207374726F6B65205B5D203020736574646173682065786368206870742073756220657863682076707420616464204D0A2020687074322076707432206E656720562063757272656E74706F696E74207374726F6B65204D0A202068707432206E656720302052206870743220767074322056207374726F6B65207D206465660A2F54726955207B207374726F6B65205B5D20302073657464617368203220636F70792076707420312E3132206D756C20616464204D0A2020687074206E656720767074202D312E3632206D756C20560A20206870742032206D756C203020560A2020687074206E65672076707420312E3632206D756C205620636C6F736570617468207374726F6B650A2020506E7420207D206465660A2F53746172207B203220636F707920506C7320437273207D206465660A2F426F7846207B207374726F6B65205B5D203020736574646173682065786368206870742073756220657863682076707420616464204D0A2020302076707432206E6567205620206870743220302056202030207670743220560A202068707432206E6567203020562020636C6F7365706174682066696C6C207D206465660A2F5472695546207B207374726F6B65205B5D203020736574646173682076707420312E3132206D756C20616464204D0A2020687074206E656720767074202D312E3632206D756C20560A20206870742032206D756C203020560A2020687074206E65672076707420312E3632206D756C205620636C6F7365706174682066696C6C207D206465660A2F54726944207B207374726F6B65205B5D20302073657464617368203220636F70792076707420312E3132206D756C20737562204D0A2020687074206E65672076707420312E3632206D756C20560A20206870742032206D756C203020560A2020687074206E656720767074202D312E3632206D756C205620636C6F736570617468207374726F6B650A2020506E7420207D206465660A2F5472694446207B207374726F6B65205B5D203020736574646173682076707420312E3132206D756C20737562204D0A2020687074206E65672076707420312E3632206D756C20560A20206870742032206D756C203020560A2020687074206E656720767074202D312E3632206D756C205620636C6F7365706174682066696C6C7D206465660A2F44696146207B207374726F6B65205B5D203020736574646173682076707420616464204D0A2020687074206E656720767074206E656720562068707420767074206E656720560A202068707420767074205620687074206E656720767074205620636C6F7365706174682066696C6C207D206465660A2F50656E74207B207374726F6B65205B5D20302073657464617368203220636F70792067736176650A20207472616E736C617465203020687074204D2034207B373220726F74617465203020687074204C7D207265706561740A2020636C6F736570617468207374726F6B652067726573746F726520506E74207D206465660A2F50656E7446207B207374726F6B65205B5D203020736574646173682067736176650A20207472616E736C617465203020687074204D2034207B373220726F74617465203020687074204C7D207265706561740A2020636C6F7365706174682066696C6C2067726573746F7265207D206465660A2F436972636C65207B207374726F6B65205B5D20302073657464617368203220636F70790A202068707420302033363020617263207374726F6B6520506E74207D206465660A2F436972636C6546207B207374726F6B65205B5D2030207365746461736820687074203020333630206172632066696C6C207D206465660A2F4330207B20424C205B5D20302073657464617368203220636F7079206D6F7665746F20767074203930203435302020617263207D2062696E64206465660A2F4331207B20424C205B5D20302073657464617368203220636F707920202020202020206D6F7665746F0A202020202020203220636F7079202076707420302039302061726320636C6F7365706174682066696C6C0A2020202020202020202020202020207670742030203336302061726320636C6F736570617468207D2062696E64206465660A2F4332207B20424C205B5D20302073657464617368203220636F7079206D6F7665746F0A202020202020203220636F70792020767074203930203138302061726320636C6F7365706174682066696C6C0A2020202020202020202020202020207670742030203336302061726320636C6F736570617468207D2062696E64206465660A2F4333207B20424C205B5D20302073657464617368203220636F7079206D6F7665746F0A202020202020203220636F707920207670742030203138302061726320636C6F7365706174682066696C6C0A2020202020202020202020202020207670742030203336302061726320636C6F736570617468207D2062696E64206465660A2F4334207B20424C205B5D20302073657464617368203220636F7079206D6F7665746F0A202020202020203220636F7079202076707420313830203237302061726320636C6F7365706174682066696C6C0A2020202020202020202020202020207670742030203336302061726320636C6F736570617468207D2062696E64206465660A2F4335207B20424C205B5D20302073657464617368203220636F7079206D6F7665746F0A202020202020203220636F707920207670742030203930206172630A202020202020203220636F7079206D6F7665746F0A202020202020203220636F7079202076707420313830203237302061726320636C6F7365706174682066696C6C0A20202020202020202020202020202076707420302033363020617263207D2062696E64206465660A2F4336207B20424C205B5D20302073657464617368203220636F7079206D6F7665746F0A2020202020203220636F70792020767074203930203237302061726320636C6F7365706174682066696C6C0A20202020202020202020202020207670742030203336302061726320636C6F736570617468207D2062696E64206465660A2F4337207B20424C205B5D20302073657464617368203220636F7079206D6F7665746F0A2020202020203220636F707920207670742030203237302061726320636C6F7365706174682066696C6C0A20202020202020202020202020207670742030203336302061726320636C6F736570617468207D2062696E64206465660A2F4338207B20424C205B5D20302073657464617368203220636F7079206D6F7665746F0A2020202020203220636F70792076707420323730203336302061726320636C6F7365706174682066696C6C0A20202020202020202020202020207670742030203336302061726320636C6F736570617468207D2062696E64206465660A2F4339207B20424C205B5D20302073657464617368203220636F7079206D6F7665746F0A2020202020203220636F7079202076707420323730203435302061726320636C6F7365706174682066696C6C0A20202020202020202020202020207670742030203336302061726320636C6F736570617468207D2062696E64206465660A2F433130207B20424C205B5D20302073657464617368203220636F7079203220636F7079206D6F7665746F2076707420323730203336302061726320636C6F7365706174682066696C6C0A202020202020203220636F7079206D6F7665746F0A202020202020203220636F707920767074203930203138302061726320636C6F7365706174682066696C6C0A2020202020202020202020202020207670742030203336302061726320636C6F736570617468207D2062696E64206465660A2F433131207B20424C205B5D20302073657464617368203220636F7079206D6F7665746F0A202020202020203220636F707920207670742030203138302061726320636C6F7365706174682066696C6C0A202020202020203220636F7079206D6F7665746F0A202020202020203220636F7079202076707420323730203336302061726320636C6F7365706174682066696C6C0A2020202020202020202020202020207670742030203336302061726320636C6F736570617468207D2062696E64206465660A2F433132207B20424C205B5D20302073657464617368203220636F7079206D6F7665746F0A202020202020203220636F7079202076707420313830203336302061726320636C6F7365706174682066696C6C0A2020202020202020202020202020207670742030203336302061726320636C6F736570617468207D2062696E64206465660A2F433133207B20424C205B5D2030207365746461736820203220636F7079206D6F7665746F0A202020202020203220636F7079202076707420302039302061726320636C6F7365706174682066696C6C0A202020202020203220636F7079206D6F7665746F0A202020202020203220636F7079202076707420313830203336302061726320636C6F7365706174682066696C6C0A2020202020202020202020202020207670742030203336302061726320636C6F736570617468207D2062696E64206465660A2F433134207B20424C205B5D20302073657464617368203220636F7079206D6F7665746F0A202020202020203220636F70792020767074203930203336302061726320636C6F7365706174682066696C6C0A20202020202020202020202020202076707420302033363020617263207D2062696E64206465660A2F433135207B20424C205B5D20302073657464617368203220636F7079207670742030203336302061726320636C6F7365706174682066696C6C0A2020202020202020202020202020207670742030203336302061726320636C6F736570617468207D2062696E64206465660A2F5265632020207B206E6577706174682034203220726F6C6C206D6F7665746F203120696E646578203020726C696E65746F2030206578636820726C696E65746F0A202020202020206E6567203020726C696E65746F20636C6F736570617468207D2062696E64206465660A2F537175617265207B2064757020526563207D2062696E64206465660A2F42737175617265207B2076707420737562206578636820767074207375622065786368207670743220537175617265207D2062696E64206465660A2F5330207B20424C205B5D20302073657464617368203220636F7079206D6F7665746F20302076707420726C696E65746F20424C2042737175617265207D2062696E64206465660A2F5331207B20424C205B5D20302073657464617368203220636F707920767074205371756172652066696C6C2042737175617265207D2062696E64206465660A2F5332207B20424C205B5D20302073657464617368203220636F707920657863682076707420737562206578636820767074205371756172652066696C6C2042737175617265207D2062696E64206465660A2F5333207B20424C205B5D20302073657464617368203220636F7079206578636820767074207375622065786368207670743220767074205265632066696C6C2042737175617265207D2062696E64206465660A2F5334207B20424C205B5D20302073657464617368203220636F7079206578636820767074207375622065786368207670742073756220767074205371756172652066696C6C2042737175617265207D2062696E64206465660A2F5335207B20424C205B5D20302073657464617368203220636F7079203220636F707920767074205371756172652066696C6C0A202020202020206578636820767074207375622065786368207670742073756220767074205371756172652066696C6C2042737175617265207D2062696E64206465660A2F5336207B20424C205B5D20302073657464617368203220636F70792065786368207670742073756220657863682076707420737562207670742076707432205265632066696C6C2042737175617265207D2062696E64206465660A2F5337207B20424C205B5D20302073657464617368203220636F70792065786368207670742073756220657863682076707420737562207670742076707432205265632066696C6C0A202020202020203220636F707920767074205371756172652066696C6C0A2020202020202042737175617265207D2062696E64206465660A2F5338207B20424C205B5D20302073657464617368203220636F7079207670742073756220767074205371756172652066696C6C2042737175617265207D2062696E64206465660A2F5339207B20424C205B5D20302073657464617368203220636F70792076707420737562207670742076707432205265632066696C6C2042737175617265207D2062696E64206465660A2F533130207B20424C205B5D20302073657464617368203220636F7079207670742073756220767074205371756172652066696C6C203220636F707920657863682076707420737562206578636820767074205371756172652066696C6C0A2020202020202042737175617265207D2062696E64206465660A2F533131207B20424C205B5D20302073657464617368203220636F7079207670742073756220767074205371756172652066696C6C203220636F7079206578636820767074207375622065786368207670743220767074205265632066696C6C0A2020202020202042737175617265207D2062696E64206465660A2F533132207B20424C205B5D20302073657464617368203220636F70792065786368207670742073756220657863682076707420737562207670743220767074205265632066696C6C2042737175617265207D2062696E64206465660A2F533133207B20424C205B5D20302073657464617368203220636F70792065786368207670742073756220657863682076707420737562207670743220767074205265632066696C6C0A202020202020203220636F707920767074205371756172652066696C6C2042737175617265207D2062696E64206465660A2F533134207B20424C205B5D20302073657464617368203220636F70792065786368207670742073756220657863682076707420737562207670743220767074205265632066696C6C0A202020202020203220636F707920657863682076707420737562206578636820767074205371756172652066696C6C2042737175617265207D2062696E64206465660A2F533135207B20424C205B5D20302073657464617368203220636F707920427371756172652066696C6C2042737175617265207D2062696E64206465660A2F4430207B206773617665207472616E736C61746520343520726F7461746520302030205330207374726F6B652067726573746F7265207D2062696E64206465660A2F4431207B206773617665207472616E736C61746520343520726F7461746520302030205331207374726F6B652067726573746F7265207D2062696E64206465660A2F4432207B206773617665207472616E736C61746520343520726F7461746520302030205332207374726F6B652067726573746F7265207D2062696E64206465660A2F4433207B206773617665207472616E736C61746520343520726F7461746520302030205333207374726F6B652067726573746F7265207D2062696E64206465660A2F4434207B206773617665207472616E736C61746520343520726F7461746520302030205334207374726F6B652067726573746F7265207D2062696E64206465660A2F4435207B206773617665207472616E736C61746520343520726F7461746520302030205335207374726F6B652067726573746F7265207D2062696E64206465660A2F4436207B206773617665207472616E736C61746520343520726F7461746520302030205336207374726F6B652067726573746F7265207D2062696E64206465660A2F4437207B206773617665207472616E736C61746520343520726F7461746520302030205337207374726F6B652067726573746F7265207D2062696E64206465660A2F4438207B206773617665207472616E736C61746520343520726F7461746520302030205338207374726F6B652067726573746F7265207D2062696E64206465660A2F4439207B206773617665207472616E736C61746520343520726F7461746520302030205339207374726F6B652067726573746F7265207D2062696E64206465660A2F443130207B206773617665207472616E736C61746520343520726F746174652030203020533130207374726F6B652067726573746F7265207D2062696E64206465660A2F443131207B206773617665207472616E736C61746520343520726F746174652030203020533131207374726F6B652067726573746F7265207D2062696E64206465660A2F443132207B206773617665207472616E736C61746520343520726F746174652030203020533132207374726F6B652067726573746F7265207D2062696E64206465660A2F443133207B206773617665207472616E736C61746520343520726F746174652030203020533133207374726F6B652067726573746F7265207D2062696E64206465660A2F443134207B206773617665207472616E736C61746520343520726F746174652030203020533134207374726F6B652067726573746F7265207D2062696E64206465660A2F443135207B206773617665207472616E736C61746520343520726F746174652030203020533135207374726F6B652067726573746F7265207D2062696E64206465660A2F44696145207B207374726F6B65205B5D203020736574646173682076707420616464204D0A2020687074206E656720767074206E656720562068707420767074206E656720560A202068707420767074205620687074206E656720767074205620636C6F736570617468207374726F6B65207D206465660A2F426F7845207B207374726F6B65205B5D203020736574646173682065786368206870742073756220657863682076707420616464204D0A2020302076707432206E656720562068707432203020562030207670743220560A202068707432206E65672030205620636C6F736570617468207374726F6B65207D206465660A2F5472695545207B207374726F6B65205B5D203020736574646173682076707420312E3132206D756C20616464204D0A2020687074206E656720767074202D312E3632206D756C20560A20206870742032206D756C203020560A2020687074206E65672076707420312E3632206D756C205620636C6F736570617468207374726F6B65207D206465660A2F5472694445207B207374726F6B65205B5D203020736574646173682076707420312E3132206D756C20737562204D0A2020687074206E65672076707420312E3632206D756C20560A20206870742032206D756C203020560A2020687074206E656720767074202D312E3632206D756C205620636C6F736570617468207374726F6B65207D206465660A2F50656E7445207B207374726F6B65205B5D203020736574646173682067736176650A20207472616E736C617465203020687074204D2034207B373220726F74617465203020687074204C7D207265706561740A2020636C6F736570617468207374726F6B652067726573746F7265207D206465660A2F4369726345207B207374726F6B65205B5D20302073657464617368200A202068707420302033363020617263207374726F6B65207D206465660A2F4F7061717565207B20677361766520636C6F736570617468203120736574677261792066696C6C2067726573746F72652030207365746772617920636C6F736570617468207D206465660A2F44696157207B207374726F6B65205B5D203020736574646173682076707420616464204D0A2020687074206E656720767074206E656720562068707420767074206E656720560A202068707420767074205620687074206E6567207670742056204F7061717565207374726F6B65207D206465660A2F426F7857207B207374726F6B65205B5D203020736574646173682065786368206870742073756220657863682076707420616464204D0A2020302076707432206E656720562068707432203020562030207670743220560A202068707432206E656720302056204F7061717565207374726F6B65207D206465660A2F5472695557207B207374726F6B65205B5D203020736574646173682076707420312E3132206D756C20616464204D0A2020687074206E656720767074202D312E3632206D756C20560A20206870742032206D756C203020560A2020687074206E65672076707420312E3632206D756C2056204F7061717565207374726F6B65207D206465660A2F5472694457207B207374726F6B65205B5D203020736574646173682076707420312E3132206D756C20737562204D0A2020687074206E65672076707420312E3632206D756C20560A20206870742032206D756C203020560A2020687074206E656720767074202D312E3632206D756C2056204F7061717565207374726F6B65207D206465660A2F50656E7457207B207374726F6B65205B5D203020736574646173682067736176650A20207472616E736C617465203020687074204D2034207B373220726F74617465203020687074204C7D207265706561740A20204F7061717565207374726F6B652067726573746F7265207D206465660A2F4369726357207B207374726F6B65205B5D20302073657464617368200A202068707420302033363020617263204F7061717565207374726F6B65207D206465660A2F426F7846696C6C207B20677361766520526563203120736574677261792066696C6C2067726573746F7265207D206465660A2F53796D626F6C2D4F626C69717565202F53796D626F6C2066696E64666F6E74205B312030202E3136372031203020305D206D616B65666F6E740A647570206C656E677468206469637420626567696E207B3120696E646578202F464944206571207B706F7020706F707D207B6465667D206966656C73657D20666F72616C6C0A63757272656E746469637420656E6420646566696E65666F6E740A2F4D4673686F77207B7B647570206475702030206765742066696E64666F6E742065786368203120676574207363616C65666F6E7420736574666F6E740A20202020205B2063757272656E74706F696E74205D2065786368206475702032206765742030206578636820726D6F7665746F206475702064757020352067657420657863682034206765740A20202020207B73686F777D207B737472696E67776964746820706F70203020726D6F7665746F7D6966656C7365206475702033206765740A20202020207B3220676574206E65672030206578636820726D6F7665746F20706F707D207B706F7020616C6F616420706F70206D6F7665746F7D6966656C73657D20666F72616C6C7D2062696E64206465660A2F4D467769647468207B302065786368207B6475702033206765747B647570206475702030206765742066696E64666F6E742065786368203120676574207363616C65666F6E7420736574666F6E740A202020202020352067657420737472696E67776964746820706F70206164647D0A202020207B706F707D206966656C73657D20666F72616C6C7D2062696E64206465660A2F4D4C73686F77207B2063757272656E74706F696E74207374726F6B65204D0A20203020657863682052204D4673686F77207D2062696E64206465660A2F4D5273686F77207B2063757272656E74706F696E74207374726F6B65204D0A20206578636820647570204D467769647468206E65672033202D3120726F6C6C2052204D4673686F77207D206465660A2F4D4373686F77207B2063757272656E74706F696E74207374726F6B65204D0A20206578636820647570204D467769647468202D32206469762033202D3120726F6C6C2052204D4673686F77207D206465660A656E640A2525456E6450726F6C6F670A676E756469637420626567696E0A67736176650A3530203530207472616E736C6174650A302E30353020302E303530207363616C650A3020736574677261790A6E6577706174680A2848656C766574696361292066696E64666F6E7420313430207363616C65666F6E7420736574666F6E740A312E30303020554C0A4C54620A35373420323830204D0A3633203020560A32373235203020520A2D3633203020560A207374726F6B650A34393020323830204D0A5B205B2848656C76657469636129203134302E3020302E302074727565207472756520282030295D0A5D202D34362E37204D5273686F770A35373420343837204D0A3633203020560A32373235203020520A2D3633203020560A207374726F6B650A34393020343837204D0A5B205B2848656C76657469636129203134302E3020302E3020747275652074727565202820302E31295D0A5D202D34362E37204D5273686F770A35373420363934204D0A3633203020560A32373235203020520A2D3633203020560A207374726F6B650A34393020363934204D0A5B205B2848656C76657469636129203134302E3020302E3020747275652074727565202820302E32295D0A5D202D34362E37204D5273686F770A35373420393032204D0A3633203020560A32373235203020520A2D3633203020560A207374726F6B650A34393020393032204D0A5B205B2848656C76657469636129203134302E3020302E3020747275652074727565202820302E33295D0A5D202D34362E37204D5273686F770A3537342031313039204D0A3633203020560A32373235203020520A2D3633203020560A207374726F6B650A3439302031313039204D0A5B205B2848656C76657469636129203134302E3020302E3020747275652074727565202820302E34295D0A5D202D34362E37204D5273686F770A3537342031333136204D0A3633203020560A32373235203020520A2D3633203020560A207374726F6B650A3439302031333136204D0A5B205B2848656C76657469636129203134302E3020302E3020747275652074727565202820302E35295D0A5D202D34362E37204D5273686F770A3537342031353233204D0A3633203020560A32373235203020520A2D3633203020560A207374726F6B650A3439302031353233204D0A5B205B2848656C76657469636129203134302E3020302E3020747275652074727565202820302E36295D0A5D202D34362E37204D5273686F770A3537342031373330204D0A3633203020560A32373235203020520A2D3633203020560A207374726F6B650A3439302031373330204D0A5B205B2848656C76657469636129203134302E3020302E3020747275652074727565202820302E37295D0A5D202D34362E37204D5273686F770A3537342031393338204D0A3633203020560A32373235203020520A2D3633203020560A207374726F6B650A3439302031393338204D0A5B205B2848656C76657469636129203134302E3020302E3020747275652074727565202820302E38295D0A5D202D34362E37204D5273686F770A3537342032313435204D0A3633203020560A32373235203020520A2D3633203020560A207374726F6B650A3439302032313435204D0A5B205B2848656C76657469636129203134302E3020302E3020747275652074727565202820302E39295D0A5D202D34362E37204D5273686F770A3537342032333532204D0A3633203020560A32373235203020520A2D3633203020560A207374726F6B650A3439302032333532204D0A5B205B2848656C76657469636129203134302E3020302E302074727565207472756520282031295D0A5D202D34362E37204D5273686F770A35373420323830204D0A3020363320560A30203230303920520A30202D363320560A207374726F6B650A35373420313430204D0A5B205B2848656C76657469636129203134302E3020302E302074727565207472756520282030295D0A5D202D34362E37204D4373686F770A3130333920323830204D0A3020363320560A30203230303920520A30202D363320560A207374726F6B650A3130333920313430204D0A5B205B2848656C76657469636129203134302E3020302E3020747275652074727565202820302E35295D0A5D202D34362E37204D4373686F770A3135303320323830204D0A3020363320560A30203230303920520A30202D363320560A207374726F6B650A3135303320313430204D0A5B205B2848656C76657469636129203134302E3020302E302074727565207472756520282031295D0A5D202D34362E37204D4373686F770A3139363820323830204D0A3020363320560A30203230303920520A30202D363320560A207374726F6B650A3139363820313430204D0A5B205B2848656C76657469636129203134302E3020302E3020747275652074727565202820312E35295D0A5D202D34362E37204D4373686F770A3234333320323830204D0A3020363320560A30203230303920520A30202D363320560A207374726F6B650A3234333320313430204D0A5B205B2848656C76657469636129203134302E3020302E302074727565207472756520282032295D0A5D202D34362E37204D4373686F770A3238393720323830204D0A3020363320560A30203230303920520A30202D363320560A207374726F6B650A3238393720313430204D0A5B205B2848656C76657469636129203134302E3020302E3020747275652074727565202820322E35295D0A5D202D34362E37204D4373686F770A3333363220323830204D0A3020363320560A30203230303920520A30202D363320560A207374726F6B650A3333363220313430204D0A5B205B2848656C76657469636129203134302E3020302E302074727565207472756520282033295D0A5D202D34362E37204D4373686F770A312E30303020554C0A4C54620A35373420323830204D0A32373838203020560A30203230373220560A2D32373838203020560A35373420323830204C0A312E30303020554C0A4C54300A323731312032323139204D0A5B205B2848656C76657469636129203134302E3020302E302074727565207472756520286C696E652031295D0A5D202D34362E37204D5273686F770A323739352032323139204D0A333939203020560A35373420323830204D0A39332032303720560A39332032303520560A39332032303020560A39332031393520560A39332031383620560A39332031373720560A39332031363520560A39322031353120560A39332031333720560A39332031323120560A39332031303320560A393320383420560A393320363520560A393320343620560A393320323520560A3933203420560A3933202D313620560A3933202D333720560A3933202D353720560A3933202D373720560A3933202D393520560A3933202D31313420560A3932202D31333020560A3933202D31343520560A3933202D31363020560A3933202D31373220560A3933202D31383220560A3933202D31393220560A3933202D31393820560A3933202D32303420560A7374726F6B650A67726573746F72650A656E640A73686F77706167650A>|ps>||||>

      \;
    </unfolded-io>

    octave\<gtr\>\ 
  </session>

  <tmdoc-copyright|2011|Michael Graffam|Joris van der Hoeven>

  <tmdoc-license|Permission is granted to copy, distribute and/or modify this
  document under the terms of the GNU Free Documentation License, Version 1.1
  or any later version published by the Free Software Foundation; with no
  Invariant Sections, with no Front-Cover Texts, and with no Back-Cover
  Texts. A copy of the license is included in the section entitled "GNU Free
  Documentation License".>
</body>

<\initial>
  <\collection>
    <associate|language|english>
  </collection>
</initial>