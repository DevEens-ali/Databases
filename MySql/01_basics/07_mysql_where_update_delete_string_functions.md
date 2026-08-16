<!DOCTYPE html>
<html lang="ur-Latn">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MySQL Notes — Part 2 | Query Console</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&family=IBM+Plex+Mono:wght@400;500;600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<style>
  :root{
    --bg: #0B1220;
    --panel: #121B2E;
    --panel-2: #17233A;
    --line: #24324D;
    --text: #E7ECF4;
    --muted: #8CA0C2;
    --amber: #F2B84B;
    --teal: #4FD1C5;
    --coral: #F0876B;
    --violet: #A78BFA;
    --mono: 'IBM Plex Mono', monospace;
    --display: 'Space Grotesk', sans-serif;
    --body: 'Inter', sans-serif;
  }
  *{box-sizing:border-box; margin:0; padding:0;}
  html{scroll-behavior:smooth;}
  body{
    background:
      radial-gradient(1200px 600px at 80% -10%, rgba(79,209,197,0.08), transparent 60%),
      radial-gradient(900px 500px at -10% 20%, rgba(167,139,250,0.06), transparent 60%),
      var(--bg);
    color:var(--text);
    font-family:var(--body);
    line-height:1.6;
    padding-bottom:80px;
  }
  ::selection{ background:var(--teal); color:#0B1220; }

  /* ---------- HERO ---------- */
  .hero{
    max-width:1100px; margin:0 auto; padding:80px 24px 40px;
    display:grid; grid-template-columns: 1.2fr 1fr; gap:40px; align-items:center;
  }
  @media(max-width:860px){ .hero{grid-template-columns:1fr; padding-top:56px;} }
  .eyebrow{
    font-family:var(--mono); font-size:12px; letter-spacing:.16em; text-transform:uppercase;
    color:var(--teal); display:flex; align-items:center; gap:10px; margin-bottom:18px;
  }
  .eyebrow::before{ content:''; width:8px; height:8px; border-radius:50%; background:var(--teal); box-shadow:0 0 12px var(--teal); animation: blink 1.6s infinite; }
  @keyframes blink{ 0%,100%{opacity:1;} 50%{opacity:.25;} }
  h1.title{
    font-family:var(--display); font-weight:700; font-size:clamp(34px,5vw,54px);
    line-height:1.06; letter-spacing:-0.02em;
  }
  h1.title span{ color:var(--amber); }
  .hero p.sub{ margin-top:18px; color:var(--muted); font-size:16px; max-width:46ch; }
  .hero-tags{ margin-top:26px; display:flex; flex-wrap:wrap; gap:8px; }
  .tag{
    font-family:var(--mono); font-size:12px; padding:6px 12px; border:1px solid var(--line);
    border-radius:100px; color:var(--muted);
  }

  .terminal{
    background:var(--panel); border:1px solid var(--line); border-radius:12px;
    box-shadow: 0 20px 60px rgba(0,0,0,.35);
    overflow:hidden;
  }
  .terminal-bar{
    display:flex; align-items:center; gap:8px; padding:10px 14px; background:var(--panel-2);
    border-bottom:1px solid var(--line);
  }
  .dot{ width:10px; height:10px; border-radius:50%; }
  .dot.r{background:#F0876B;} .dot.y{background:#F2B84B;} .dot.g{background:#4FD1C5;}
  .terminal-label{ margin-left:8px; font-family:var(--mono); font-size:11px; color:var(--muted); }
  .terminal-body{ padding:20px; font-family:var(--mono); font-size:14px; min-height:150px; }
  .terminal-body .kw{ color:var(--coral); }
  .terminal-body .str{ color:var(--amber); }
  .terminal-body .col{ color:var(--teal); }
  .caret{ display:inline-block; width:8px; height:16px; background:var(--teal); vertical-align:middle; animation: blink 1s infinite; }

  /* ---------- PIPELINE ---------- */
  .pipeline-wrap{ max-width:1100px; margin:20px auto 60px; padding:0 24px; }
  .pipeline{
    display:flex; gap:0; overflow-x:auto; padding:22px 4px; border-top:1px dashed var(--line); border-bottom:1px dashed var(--line);
  }
  .pipe-step{
    flex:0 0 auto; font-family:var(--mono); font-size:12px; color:var(--muted);
    padding:8px 16px; border-right:1px solid var(--line); white-space:nowrap;
  }
  .pipe-step b{ color:var(--text); font-weight:600; }
  .pipe-step:last-child{ border-right:none; }

  /* ---------- SECTIONS ---------- */
  .wrap{ max-width:1100px; margin:0 auto; padding:0 24px; }
  section.topic{ padding:70px 0; border-top:1px solid var(--line); }
  section.topic:first-of-type{ border-top:none; }
  .topic-head{ display:flex; align-items:baseline; gap:16px; margin-bottom:10px; flex-wrap:wrap; }
  .topic-num{ font-family:var(--mono); color:var(--muted); font-size:13px; }
  h2.topic-title{ font-family:var(--display); font-size:clamp(24px,3vw,32px); font-weight:600; }
  h2.topic-title .accent{ color:var(--teal); }
  .topic-desc{ color:var(--muted); max-width:70ch; margin:14px 0 26px; font-size:15.5px; }
  .trick{
    display:inline-flex; align-items:center; gap:8px; font-family:var(--mono); font-size:13px;
    color:var(--amber); background:rgba(242,184,75,.08); border:1px solid rgba(242,184,75,.25);
    padding:8px 14px; border-radius:8px; margin-bottom:26px;
  }

  /* ---------- QUERY CARD ---------- */
  .card{
    background:var(--panel); border:1px solid var(--line); border-radius:14px; overflow:hidden;
  }
  .card-head{
    display:flex; justify-content:space-between; align-items:center; padding:14px 18px;
    background:var(--panel-2); border-bottom:1px solid var(--line);
  }
  .card-head .path{ font-family:var(--mono); font-size:12px; color:var(--muted); }
  .run-btn{
    font-family:var(--mono); font-size:12.5px; font-weight:600; letter-spacing:.03em;
    background:var(--teal); color:#08201d; border:none; padding:9px 18px; border-radius:8px;
    cursor:pointer; display:inline-flex; align-items:center; gap:8px; transition:transform .15s ease, box-shadow .15s ease;
  }
  .run-btn:hover{ transform:translateY(-1px); box-shadow:0 6px 20px rgba(79,209,197,.25); }
  .run-btn:active{ transform:translateY(0); }
  .run-btn.busy{ opacity:.6; pointer-events:none; }
  .card-query{
    font-family:var(--mono); font-size:14px; padding:18px; color:var(--text); white-space:pre-wrap;
    border-bottom:1px solid var(--line); background:
      linear-gradient(180deg, rgba(79,209,197,0.03), transparent 40%);
  }
  .card-query .kw{ color:var(--coral); font-weight:600; }
  .card-query .str{ color:var(--amber); }
  .card-query .col{ color:var(--teal); }
  .card-query .fn{ color:var(--violet); }
  .card-out{ padding:18px; min-height:70px; }

  table.data{ width:100%; border-collapse:collapse; font-family:var(--mono); font-size:13.5px; }
  table.data th{ text-align:left; color:var(--muted); font-weight:500; padding:8px 10px; border-bottom:1px solid var(--line); font-size:12px; text-transform:uppercase; letter-spacing:.05em; }
  table.data td{ padding:9px 10px; border-bottom:1px solid rgba(36,50,77,.6); transition: all .35s ease; }
  table.data tr.row{ transition: opacity .4s ease, transform .4s ease; }
  table.data tr.row.dropped{ opacity:0; transform: translateX(-12px) scale(.98); }
  .hl{ color:var(--amber); font-weight:600; }
  .newcol{ color:var(--teal); }
  .empty-msg{ font-family:var(--mono); color:var(--muted); font-size:13px; padding:10px 0; }
  .status-msg{ font-family:var(--mono); font-size:12.5px; color:var(--teal); margin-top:10px; min-height:16px; }

  /* ---------- concat animation ---------- */
  .stitch{ display:flex; gap:6px; align-items:center; font-family:var(--mono); }
  .chip{ padding:5px 10px; border-radius:6px; background:var(--panel-2); border:1px solid var(--line); transition: all .5s cubic-bezier(.2,.8,.2,1); }
  .chip.merged{ background:rgba(79,209,197,.12); border-color:var(--teal); color:var(--teal); }

  /* ---------- footer / revision ---------- */
  .revision{
    margin-top:60px; padding:36px; border:1px solid var(--line); border-radius:14px; background:var(--panel);
  }
  .revision h3{ font-family:var(--display); font-size:20px; margin-bottom:18px; }
  .flow-grid{ display:grid; grid-template-columns:repeat(auto-fill,minmax(150px,1fr)); gap:10px; }
  .flow-item{
    font-family:var(--mono); font-size:12.5px; text-align:center; padding:12px 8px; border:1px solid var(--line);
    border-radius:8px; color:var(--muted); background:var(--panel-2);
  }
  .flow-item.active{ color:var(--teal); border-color:var(--teal); box-shadow:0 0 0 1px var(--teal) inset; }

  .filepath{
    font-family:var(--mono); font-size:13px; color:var(--muted); background:var(--panel);
    border:1px solid var(--line); border-radius:10px; padding:16px 18px; margin-top:16px;
    white-space:pre;
  }
  .filepath b{ color:var(--teal); }

  footer{ text-align:center; padding:60px 24px 0; color:var(--muted); font-family:var(--mono); font-size:12px; }
</style>
</head>
<body>

<div class="hero">
  <div>
    <div class="eyebrow">Live Query Console · Roman Urdu Notes</div>
    <h1 class="title">MySQL Notes <span>— Part 2</span></h1>
    <p class="sub">WHERE se lekar CONCAT() tak — har concept ke saath ek live mini-console jo query "run" karke tumhe result table live dikhata hai. Scroll karo, RUN dabao, dekho kya hota hai.</p>
    <div class="hero-tags">
      <span class="tag">WHERE</span><span class="tag">AND / OR</span><span class="tag">UPDATE</span>
      <span class="tag">DELETE</span><span class="tag">LENGTH()</span><span class="tag">UPPER()</span>
      <span class="tag">LOWER()</span><span class="tag">CONCAT()</span>
    </div>
  </div>
  <div class="terminal">
    <div class="terminal-bar">
      <span class="dot r"></span><span class="dot y"></span><span class="dot g"></span>
      <span class="terminal-label">customers.sql</span>
    </div>
    <div class="terminal-body" id="heroTyper"></div>
  </div>
</div>

<div class="pipeline-wrap">
  <div class="pipeline" id="pipelineTop">
    <div class="pipe-step"><b>DATABASE</b></div>
    <div class="pipe-step"><b>TABLES</b></div>
    <div class="pipe-step"><b>PRIMARY KEY</b></div>
    <div class="pipe-step"><b>AUTO_INCREMENT</b></div>
    <div class="pipe-step"><b>INSERT</b></div>
    <div class="pipe-step"><b>SELECT</b></div>
    <div class="pipe-step"><b>ALIAS</b></div>
    <div class="pipe-step"><b>WHERE</b></div>
    <div class="pipe-step"><b>AND / OR</b></div>
    <div class="pipe-step"><b>UPDATE</b></div>
    <div class="pipe-step"><b>DELETE</b></div>
    <div class="pipe-step"><b>STRING FUNCTIONS</b></div>
  </div>
</div>

<div class="wrap">

  <!-- 1. WHERE -->
  <section class="topic" id="where">
    <div class="topic-head"><span class="topic-num">01</span><h2 class="topic-title">WHERE <span class="accent">Clause</span></h2></div>
    <p class="topic-desc"><code>WHERE</code> clause ka use specific rows ko condition ke basis par filter karne ke liye hota hai. SELECT columns choose karta hai, WHERE rows choose karta hai.</p>
    <div class="trick">🧠 WHERE = WHICH ROW?</div>
    <div class="card">
      <div class="card-head">
        <span class="path">customers</span>
        <button class="run-btn" onclick="runWhere()">▶ RUN QUERY</button>
      </div>
      <div class="card-query"><span class="kw">SELECT</span> * <span class="kw">FROM</span> <span class="col">customers</span>
<span class="kw">WHERE</span> <span class="col">city</span> = <span class="str">'Lahore'</span>;</div>
      <div class="card-out" id="whereOut"></div>
      <div class="status-msg" id="whereStatus" style="padding:0 18px 16px;"></div>
    </div>
  </section>

  <!-- 2. AND -->
  <section class="topic" id="and">
    <div class="topic-head"><span class="topic-num">02</span><h2 class="topic-title">AND <span class="accent">Operator</span></h2></div>
    <p class="topic-desc">Multiple conditions lagane ke liye <code>AND</code> use hota hai — dono conditions TRUE honi chahiye tabhi row return hogi.</p>
    <div class="trick">🧠 AND → dono chahiye</div>
    <div class="card">
      <div class="card-head">
        <span class="path">products</span>
        <button class="run-btn" onclick="runAnd()">▶ RUN QUERY</button>
      </div>
      <div class="card-query"><span class="kw">SELECT</span> * <span class="kw">FROM</span> <span class="col">products</span>
<span class="kw">WHERE</span> <span class="col">price</span> > 10000
<span class="kw">AND</span> <span class="col">stock</span> > 0;</div>
      <div class="card-out" id="andOut"></div>
      <div class="status-msg" id="andStatus" style="padding:0 18px 16px;"></div>
    </div>
  </section>

  <!-- 3. OR -->
  <section class="topic" id="or">
    <div class="topic-head"><span class="topic-num">03</span><h2 class="topic-title">OR <span class="accent">Operator</span></h2></div>
    <p class="topic-desc">Jab multiple conditions mein se koi ek bhi TRUE ho jaye toh row return hoti hai.</p>
    <div class="trick">🧠 OR → koi ek chalega</div>
    <div class="card">
      <div class="card-head">
        <span class="path">customers</span>
        <button class="run-btn" onclick="runOr()">▶ RUN QUERY</button>
      </div>
      <div class="card-query"><span class="kw">SELECT</span> * <span class="kw">FROM</span> <span class="col">customers</span>
<span class="kw">WHERE</span> <span class="col">city</span> = <span class="str">'Lahore'</span>
<span class="kw">OR</span> <span class="col">city</span> = <span class="str">'Karachi'</span>;</div>
      <div class="card-out" id="orOut"></div>
      <div class="status-msg" id="orStatus" style="padding:0 18px 16px;"></div>
    </div>
  </section>

  <!-- 4. UPDATE -->
  <section class="topic" id="update">
    <div class="topic-head"><span class="topic-num">04</span><h2 class="topic-title">UPDATE <span class="accent">Statement</span></h2></div>
    <p class="topic-desc">Existing data ko change/modify karne ke liye <code>UPDATE</code> use hota hai. <b style="color:var(--coral)">Golden Rule:</b> UPDATE karne se pehle hamesha WHERE condition check karo, warna saari rows update ho sakti hain.</p>
    <div class="card">
      <div class="card-head">
        <span class="path">customers</span>
        <button class="run-btn" onclick="runUpdate()">▶ RUN QUERY</button>
      </div>
      <div class="card-query"><span class="kw">UPDATE</span> <span class="col">customers</span>
<span class="kw">SET</span> <span class="col">city</span> = <span class="str">'Islamabad'</span>
<span class="kw">WHERE</span> <span class="col">cust_id</span> = 3;</div>
      <div class="card-out" id="updateOut"></div>
      <div class="status-msg" id="updateStatus" style="padding:0 18px 16px;"></div>
    </div>
  </section>

  <!-- 5. DELETE -->
  <section class="topic" id="delete">
    <div class="topic-head"><span class="topic-num">05</span><h2 class="topic-title">DELETE <span class="accent">Statement</span></h2></div>
    <p class="topic-desc">Table se existing rows remove karne ke liye <code>DELETE</code> use hota hai. Safe habit: pehle <code>SELECT</code> karke verify karo, phir <code>DELETE</code> chalao.</p>
    <div class="trick">🧠 SELECT → Verify → DELETE</div>
    <div class="card">
      <div class="card-head">
        <span class="path">customers</span>
        <button class="run-btn" onclick="runDelete()">▶ RUN QUERY</button>
      </div>
      <div class="card-query"><span class="kw">DELETE FROM</span> <span class="col">customers</span>
<span class="kw">WHERE</span> <span class="col">cust_id</span> = 4;</div>
      <div class="card-out" id="deleteOut"></div>
      <div class="status-msg" id="deleteStatus" style="padding:0 18px 16px;"></div>
    </div>
  </section>

  <!-- 6. String functions intro + LENGTH -->
  <section class="topic" id="length">
    <div class="topic-head"><span class="topic-num">06</span><h2 class="topic-title">LENGTH<span class="accent">()</span></h2></div>
    <p class="topic-desc">String functions text/string data ko manipulate ya analyze karne ke liye hote hain. <code>LENGTH()</code> kisi string ki length (characters ki ginti) return karta hai.</p>
    <div class="trick">🧠 LENGTH() → "Kitna long?"</div>
    <div class="card">
      <div class="card-head">
        <span class="path">customers</span>
        <button class="run-btn" onclick="runLength()">▶ RUN QUERY</button>
      </div>
      <div class="card-query"><span class="kw">SELECT</span> <span class="col">first_name</span>, <span class="fn">LENGTH</span>(<span class="col">first_name</span>) <span class="kw">AS</span> name_length
<span class="kw">FROM</span> <span class="col">customers</span>;</div>
      <div class="card-out" id="lengthOut"></div>
    </div>
  </section>

  <!-- 7. UPPER -->
  <section class="topic" id="upper">
    <div class="topic-head"><span class="topic-num">07</span><h2 class="topic-title">UPPER<span class="accent">()</span></h2></div>
    <p class="topic-desc">Text ko UPPERCASE mein convert karta hai.</p>
    <div class="trick">🧠 UPPER() → text ko UPPER karo</div>
    <div class="card">
      <div class="card-head">
        <span class="path">customers</span>
        <button class="run-btn" onclick="runUpper()">▶ RUN QUERY</button>
      </div>
      <div class="card-query"><span class="kw">SELECT</span> <span class="fn">UPPER</span>(<span class="col">first_name</span>) <span class="kw">AS</span> uppercase_name
<span class="kw">FROM</span> <span class="col">customers</span>;</div>
      <div class="card-out" id="upperOut"></div>
    </div>
  </section>

  <!-- 8. LOWER -->
  <section class="topic" id="lower">
    <div class="topic-head"><span class="topic-num">08</span><h2 class="topic-title">LOWER<span class="accent">()</span></h2></div>
    <p class="topic-desc">Text ko lowercase mein convert karta hai.</p>
    <div class="trick">🧠 LOWER() → text ko lower karo</div>
    <div class="card">
      <div class="card-head">
        <span class="path">customers</span>
        <button class="run-btn" onclick="runLower()">▶ RUN QUERY</button>
      </div>
      <div class="card-query"><span class="kw">SELECT</span> <span class="fn">LOWER</span>(<span class="col">first_name</span>) <span class="kw">AS</span> lowercase_name
<span class="kw">FROM</span> <span class="col">customers</span>;</div>
      <div class="card-out" id="lowerOut"></div>
    </div>
  </section>

  <!-- 9. CONCAT -->
  <section class="topic" id="concat">
    <div class="topic-head"><span class="topic-num">09</span><h2 class="topic-title">CONCAT<span class="accent">()</span></h2></div>
    <p class="topic-desc">Multiple strings ko combine/join karta hai. Yaad rakho: <code>''</code> (empty string) mein koi space nahi hota, jabke <code>' '</code> ek space deta hai — yehi <b style="color:var(--amber)">AneesAli</b> vs <b style="color:var(--teal)">Anees Ali</b> ka farq hai.</p>
    <div class="card">
      <div class="card-head">
        <span class="path">customers</span>
        <button class="run-btn" onclick="runConcat()">▶ RUN QUERY</button>
      </div>
      <div class="card-query"><span class="kw">SELECT</span> <span class="fn">CONCAT</span>(<span class="col">first_name</span>, <span class="str">' '</span>, <span class="col">last_name</span>) <span class="kw">AS</span> customer_name
<span class="kw">FROM</span> <span class="col">customers</span>;</div>
      <div class="card-out" id="concatOut">
        <div class="stitch" id="concatStitch" style="margin-bottom:16px;"></div>
      </div>
    </div>
  </section>

  <!-- 10. Combine -->
  <section class="topic" id="combine">
    <div class="topic-head"><span class="topic-num">10</span><h2 class="topic-title">Combine <span class="accent">Everything</span></h2></div>
    <p class="topic-desc">Ab tak jo seekha — CONCAT + UPPER + ALIAS + WHERE — sab ek query mein combine karke dekho.</p>
    <div class="card">
      <div class="card-head">
        <span class="path">customers</span>
        <button class="run-btn" onclick="runCombine()">▶ RUN QUERY</button>
      </div>
      <div class="card-query"><span class="kw">SELECT</span> <span class="fn">CONCAT</span>(<span class="fn">UPPER</span>(<span class="col">first_name</span>), <span class="str">' '</span>, <span class="fn">UPPER</span>(<span class="col">last_name</span>)) <span class="kw">AS</span> customer_name
<span class="kw">FROM</span> <span class="col">customers</span>
<span class="kw">WHERE</span> <span class="col">city</span> = <span class="str">'Lahore'</span>;</div>
      <div class="card-out" id="combineOut"></div>
      <div class="status-msg" id="combineStatus" style="padding:0 18px 16px;"></div>
    </div>
  </section>

  <div class="revision">
    <h3>🧠 Master Revision Flow</h3>
    <div class="flow-grid" id="flowGrid"></div>
  </div>

  <div class="filepath">📁 mysql/
├── 01_mysql_basics.md
├── 02_database_and_tables.md
├── 03_primary_key_auto_increment_alias.md
└── <b>04_where_update_delete_string_functions.md</b></div>

</div>

<footer>made with ♥ — MySQL Notes Part 2 · agla stop: more string functions 🔥</footer>

<script>
// ---------------- DATA ----------------
let customers = [
  {cust_id:1, first_name:'Anees', last_name:'Ali', city:'Lahore'},
  {cust_id:2, first_name:'Ahmed', last_name:'Khan', city:'Karachi'},
  {cust_id:3, first_name:'Sara', last_name:'Malik', city:'Islamabad'},
  {cust_id:4, first_name:'Alex', last_name:'Chen', city:'Lahore'},
  {cust_id:5, first_name:'Hina', last_name:'Raza', city:'Multan'},
];
let products = [
  {prod_id:1, name:'Laptop', price:85000, stock:5},
  {prod_id:2, name:'Mouse', price:1500, stock:0},
  {prod_id:3, name:'Monitor', price:22000, stock:12},
  {prod_id:4, name:'Keyboard', price:3000, stock:0},
];

function renderTable(el, rows, cols){
  let html = '<table class="data"><thead><tr>' + cols.map(c=>`<th>${c.label}</th>`).join('') + '</tr></thead><tbody>';
  rows.forEach((r,i)=>{
    html += `<tr class="row" data-idx="${i}">` + cols.map(c=>`<td>${c.render ? c.render(r) : r[c.key]}</td>`).join('') + '</tr>';
  });
  html += '</tbody></table>';
  el.innerHTML = html;
}

function dropRows(el, predicateKeep){
  // fade out rows that don't match, keep the rest
  const trs = el.querySelectorAll('tr.row');
  trs.forEach((tr, i)=>{
    if(!predicateKeep(i)){
      tr.classList.add('dropped');
      setTimeout(()=>{ tr.remove(); }, 420);
    }
  });
}

function busy(btn, ms, cb){
  btn.classList.add('busy');
  const old = btn.textContent;
  btn.textContent = '⏳ RUNNING…';
  setTimeout(()=>{
    cb();
    btn.classList.remove('busy');
    btn.textContent = old;
  }, ms);
}

// ---------------- 1. WHERE ----------------
function runWhere(){
  const btn = event.currentTarget;
  const out = document.getElementById('whereOut');
  const status = document.getElementById('whereStatus');
  status.textContent = '';
  renderTable(out, customers, [
    {key:'cust_id', label:'cust_id'},
    {key:'first_name', label:'first_name'},
    {key:'last_name', label:'last_name'},
    {key:'city', label:'city', render:r=> r.city==='Lahore' ? `<span class="hl">${r.city}</span>` : r.city},
  ]);
  busy(btn, 500, ()=>{
    dropRows(out, i => customers[i].city === 'Lahore');
    setTimeout(()=>{ status.textContent = `✔ ${customers.filter(c=>c.city==='Lahore').length} row(s) returned — city = 'Lahore'`; }, 450);
  });
}

// ---------------- 2. AND ----------------
function runAnd(){
  const btn = event.currentTarget;
  const out = document.getElementById('andOut');
  const status = document.getElementById('andStatus');
  status.textContent = '';
  renderTable(out, products, [
    {key:'prod_id', label:'prod_id'},
    {key:'name', label:'name'},
    {key:'price', label:'price', render:r=> r.price>10000 ? `<span class="hl">${r.price}</span>` : r.price},
    {key:'stock', label:'stock', render:r=> r.stock>0 ? `<span class="hl">${r.stock}</span>` : r.stock},
  ]);
  busy(btn, 500, ()=>{
    dropRows(out, i => products[i].price > 10000 && products[i].stock > 0);
    setTimeout(()=>{
      const n = products.filter(p=>p.price>10000 && p.stock>0).length;
      status.textContent = `✔ ${n} row(s) returned — dono conditions TRUE`;
    }, 450);
  });
}

// ---------------- 3. OR ----------------
function runOr(){
  const btn = event.currentTarget;
  const out = document.getElementById('orOut');
  const status = document.getElementById('orStatus');
  status.textContent = '';
  renderTable(out, customers, [
    {key:'cust_id', label:'cust_id'},
    {key:'first_name', label:'first_name'},
    {key:'city', label:'city', render:r=> (r.city==='Lahore'||r.city==='Karachi') ? `<span class="hl">${r.city}</span>` : r.city},
  ]);
  busy(btn, 500, ()=>{
    dropRows(out, i => customers[i].city === 'Lahore' || customers[i].city === 'Karachi');
    setTimeout(()=>{
      const n = customers.filter(c=>c.city==='Lahore'||c.city==='Karachi').length;
      status.textContent = `✔ ${n} row(s) returned — Lahore ya Karachi`;
    }, 450);
  });
}

// ---------------- 4. UPDATE ----------------
function runUpdate(){
  const btn = event.currentTarget;
  const out = document.getElementById('updateOut');
  const status = document.getElementById('updateStatus');
  status.textContent = '';
  renderTable(out, customers, [
    {key:'cust_id', label:'cust_id'},
    {key:'first_name', label:'first_name'},
    {key:'city', label:'city', render: r => `<span id="city-${r.cust_id}">${r.city}</span>`},
  ]);
  busy(btn, 500, ()=>{
    const cell = document.getElementById('city-3');
    cell.style.transition = 'color .3s ease';
    cell.style.color = 'var(--amber)';
    setTimeout(()=>{
      customers = customers.map(c => c.cust_id===3 ? {...c, city:'Islamabad'} : c);
      cell.textContent = 'Islamabad';
      status.textContent = `✔ 1 row updated — cust_id = 3 ki city ab Islamabad hai`;
    }, 350);
  });
}

// ---------------- 5. DELETE ----------------
function runDelete(){
  const btn = event.currentTarget;
  const out = document.getElementById('deleteOut');
  const status = document.getElementById('deleteStatus');
  status.textContent = '';
  if(!customers.find(c=>c.cust_id===4)){
    status.textContent = '⚠ cust_id = 4 pehle hi delete ho chuki hai — page refresh karke dobara try karo.';
    return;
  }
  renderTable(out, customers, [
    {key:'cust_id', label:'cust_id', render:r=> r.cust_id===4 ? `<span class="hl">${r.cust_id}</span>` : r.cust_id},
    {key:'first_name', label:'first_name'},
    {key:'city', label:'city'},
  ]);
  busy(btn, 500, ()=>{
    dropRows(out, i => customers[i].cust_id !== 4);
    setTimeout(()=>{
      customers = customers.filter(c=>c.cust_id!==4);
      status.textContent = `✔ 1 row deleted — cust_id = 4 remove ho gayi`;
    }, 450);
  });
}

// ---------------- 6. LENGTH ----------------
function runLength(){
  const btn = event.currentTarget;
  const out = document.getElementById('lengthOut');
  renderTable(out, customers, [
    {key:'first_name', label:'first_name'},
    {key:'name_length', label:'name_length', render:r=>`<span id="len-${r.cust_id}" class="newcol">…</span>`},
  ]);
  busy(btn, 400, ()=>{
    customers.forEach(c=>{
      const cell = document.getElementById(`len-${c.cust_id}`);
      let n = 0;
      const target = c.first_name.length;
      const t = setInterval(()=>{
        n++;
        cell.textContent = n;
        if(n>=target) clearInterval(t);
      }, 60);
    });
  });
}

// ---------------- 7. UPPER ----------------
function runUpper(){
  const btn = event.currentTarget;
  const out = document.getElementById('upperOut');
  renderTable(out, customers, [
    {key:'first_name', label:'first_name'},
    {key:'uppercase_name', label:'uppercase_name', render:r=>`<span id="up-${r.cust_id}" class="newcol">${r.first_name}</span>`},
  ]);
  busy(btn, 350, ()=>{
    customers.forEach(c=>{
      const cell = document.getElementById(`up-${c.cust_id}`);
      setTimeout(()=>{ cell.style.transition='color .3s'; cell.textContent = c.first_name.toUpperCase(); }, 100);
    });
  });
}

// ---------------- 8. LOWER ----------------
function runLower(){
  const btn = event.currentTarget;
  const out = document.getElementById('lowerOut');
  renderTable(out, customers, [
    {key:'first_name', label:'first_name'},
    {key:'lowercase_name', label:'lowercase_name', render:r=>`<span id="lo-${r.cust_id}" class="newcol">${r.first_name.toUpperCase()}</span>`},
  ]);
  busy(btn, 350, ()=>{
    customers.forEach(c=>{
      const cell = document.getElementById(`lo-${c.cust_id}`);
      setTimeout(()=>{ cell.style.transition='color .3s'; cell.textContent = c.first_name.toLowerCase(); }, 100);
    });
  });
}

// ---------------- 9. CONCAT ----------------
function runConcat(){
  const btn = event.currentTarget;
  const wrap = document.getElementById('concatStitch');
  const out = document.getElementById('concatOut');
  busy(btn, 100, ()=>{
    const c = customers[0];
    wrap.innerHTML = `<span class="chip" id="chipA">${c.first_name}</span><span class="chip" id="chipS">' '</span><span class="chip" id="chipB">${c.last_name}</span>`;
    setTimeout(()=>{
      document.getElementById('chipA').classList.add('merged');
      document.getElementById('chipS').classList.add('merged');
      document.getElementById('chipB').classList.add('merged');
    }, 400);
    setTimeout(()=>{
      renderTable(out, customers, [
        {key:'customer_name', label:'customer_name', render:r=>`<span class="newcol">${r.first_name} ${r.last_name}</span>`},
      ]);
      out.prepend(wrap);
    }, 900);
  });
}

// ---------------- 10. COMBINE ----------------
function runCombine(){
  const btn = event.currentTarget;
  const out = document.getElementById('combineOut');
  const status = document.getElementById('combineStatus');
  status.textContent = '';
  renderTable(out, customers, [
    {key:'customer_name', label:'customer_name', render:r=>`<span id="cmb-${r.cust_id}">${r.first_name} ${r.last_name} · ${r.city}</span>`},
  ]);
  busy(btn, 500, ()=>{
    dropRows(out, i => customers[i].city === 'Lahore');
    setTimeout(()=>{
      customers.filter(c=>c.city==='Lahore').forEach(c=>{
        const cell = document.getElementById(`cmb-${c.cust_id}`);
        if(cell) cell.innerHTML = `<span class="newcol">${(c.first_name+' '+c.last_name).toUpperCase()}</span>`;
      });
      const n = customers.filter(c=>c.city==='Lahore').length;
      status.textContent = `✔ ${n} row(s) — CONCAT + UPPER + WHERE combined`;
    }, 480);
  });
}

// ---------------- Hero typing animation ----------------
const heroQueries = [
`<span class="kw">SELECT</span> <span class="fn">CONCAT</span>(<span class="fn">UPPER</span>(first_name),' ',last_name)
<span class="kw">FROM</span> customers
<span class="kw">WHERE</span> city = <span class="str">'Lahore'</span>;`,
`<span class="kw">UPDATE</span> customers
<span class="kw">SET</span> city = <span class="str">'Islamabad'</span>
<span class="kw">WHERE</span> cust_id = 3;`,
`<span class="kw">SELECT</span> <span class="fn">LENGTH</span>(first_name) <span class="kw">AS</span> name_length
<span class="kw">FROM</span> customers;`,
];
let heroIdx = 0;
function typeHero(){
  const el = document.getElementById('heroTyper');
  const raw = heroQueries[heroIdx];
  el.innerHTML = raw + '<span class="caret"></span>';
  heroIdx = (heroIdx+1) % heroQueries.length;
}
typeHero();
setInterval(typeHero, 3400);

// ---------------- Master revision flow ----------------
const flow = ['DATABASE','TABLES','PRIMARY KEY','AUTO_INCREMENT','INSERT','SELECT','ALIAS','WHERE','AND / OR','UPDATE','DELETE','STRING FUNCTIONS','LENGTH()','UPPER()','LOWER()','CONCAT()'];
const grid = document.getElementById('flowGrid');
flow.forEach((f,i)=>{
  const d = document.createElement('div');
  d.className='flow-item'; d.textContent=f;
  grid.appendChild(d);
});
let flowIdx = 0;
setInterval(()=>{
  [...grid.children].forEach(c=>c.classList.remove('active'));
  grid.children[flowIdx].classList.add('active');
  flowIdx = (flowIdx+1) % grid.children.length;
}, 700);

// pipeline highlight sync with scroll
const pipeSteps = document.querySelectorAll('.pipe-step');
const topics = document.querySelectorAll('section.topic');
const map = {where:7, and:8, or:8, update:9, delete:10, length:11, upper:11, lower:11, concat:11, combine:11};
const io = new IntersectionObserver((entries)=>{
  entries.forEach(e=>{
    if(e.isIntersecting){
      pipeSteps.forEach(p=>p.style.color='');
      const idx = map[e.target.id];
      if(idx!==undefined && pipeSteps[idx]){ pipeSteps[idx].style.color = 'var(--teal)'; }
    }
  });
}, {threshold:.4});
topics.forEach(t=>io.observe(t));
</script>
</body>
</html>