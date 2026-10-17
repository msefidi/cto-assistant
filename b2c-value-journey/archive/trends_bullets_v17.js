// 'Trends and patterns' card removed from the Overview in v18 (20 Sep 2026) on Mahyar's request; kept for re-adding when the board questions arrive.
// Needs: <section><div class="section-h"><h2>Trends and patterns</h2>...</div><div class="card"><ul class="trends" id="trends"></ul></div></section> and a renderTrends(rows) call in render().
/* trends: computed sentences */
function renderTrends(rows){
  const by = (m) => rows.filter(r=>r.m===m);
  const sizes = MONTHS.map(m => ({m, n: by(m).length}));
  const season = (mm) => sizes.filter(d => mm.includes(d.m.slice(5))), avg = a => a.length ? Math.round(a.reduce((x,d)=>x+d.n,0)/a.length) : 0;
  const share = (rs, f) => rs.length ? Math.round(100*count(rs, f)/rs.length) : null;
  const obs30 = w => rows.filter(r => r.o30 && w.includes(r.m.slice(5)));
  const nov = obs30(["11"]), summer = obs30(["07","08"]);
  const full365 = rows.filter(r=>r.o365), y1rows = rows.filter(r=>r.y1o && r.o365);
  const grp = k => y1rows.filter(r => catOf(r,365)===k), rate = rs => rs.length ? Math.round(100*count(rs, r=>r.y1)/rs.length) : null;
  const fullM = MONTHS.filter(m => y1Complete(by(m))), f3 = fullM.slice(0,3), l3 = fullM.slice(-3), y1 = ms => { const rs = rows.filter(r=>ms.includes(r.m) && r.y1o); return rs.length ? Math.round(100*count(rs, r=>r.y1)/rs.length) : null; };
  const y2c = MONTHS.filter(m => { const r = by(m); return r.length && r.every(x=>x.y2o || x.cyc>1); }), y2 = m => { const rs = by(m).filter(r=>r.y2o); return rs.length ? `${shortLabel(m)} ${Math.round(100*count(rs, r=>r.y2)/rs.length)}%` : null; };
  const intent = (ms, k) => { const rs = rows.filter(r=>ms.includes(r.m)); return rs.length ? Math.round(100*count(rs, r=>r.intent===k)/rs.length) : null; };
  const y1M = MONTHS.filter(m=>m<="2025-07"), y2M = MONTHS.filter(m=>m>="2025-08");
  const items = [
    `<b>Acquisition is seasonal.</b> Sep–Nov cohorts average ${fmt(avg(season(["09","10","11"])))} new members, Jun–Aug cohorts ${fmt(avg(season(["06","07","08"])))}. November is the peak in both years (${fmt(sizes.find(d=>d.m==="2024-11")?.n||0)} and ${fmt(sizes.find(d=>d.m==="2025-11")?.n||0)}).`,
    `<b>The membership is sold by the Refresher calendar.</b> Refresher-led intent is ${intent(y1M,"R")}% in the first year and ${intent(y2M,"R")}% in the second. The movers are the CME products: On-demand accredited-led ${intent(y1M,"A")}% → ${intent(y2M,"A")}%, SYFAT-led ${intent(y1M,"S")}% → ${intent(y2M,"S")}%, while generic On-demand-led falls ${intent(y1M,"O")}% → ${intent(y2M,"O")}%. Webinar-led stays at ${intent(y2M,"W")}%.`,
    `<b>The first month mirrors the season.</b> November joiners sit in a course right away (Live-only ${share(nov, r=>catOf(r,30)==="L")}% after 30 days, Inactive ${share(nov, r=>catOf(r,30)==="I")}%); July and August joiners wait (Inactive ${share(summer, r=>catOf(r,30)==="I")}%, Digital-only ${share(summer, r=>catOf(r,30)==="D")}%).`,
    `<b>By the end of year one, almost everyone has attended live and few have built a digital habit.</b> Across the fully observable cohorts, Live-only is ${share(full365, r=>catOf(r,365)==="L")}%, Hybrid ${share(full365, r=>catOf(r,365)==="H")}%, Digital-only ${share(full365, r=>catOf(r,365)==="D")}%, Inactive ${share(full365, r=>catOf(r,365)==="I")}%.`,
    `<b>Year-1 renewal is drifting down.</b> ${y1(f3)}% for the ${f3.length ? shortLabel(f3[0])+"–"+shortLabel(f3[f3.length-1]) : ""} cohorts, ${y1(l3)}% for ${l3.length ? shortLabel(l3[0])+"–"+shortLabel(l3[l3.length-1]) : ""}. Year 2 is complete for ${y2c.length} cohort${y2c.length===1?"":"s"} only${y2c.length ? ` (${y2c.map(y2).join(", ")})` : ""}.`,
    `<b>Year-1 renewal does not depend on behaviour.</b> Hybrid ${rate(grp("H"))}%, Live-only ${rate(grp("L"))}%, Digital-only ${rate(grp("D"))}%, Low/Episodic ${rate(grp("E"))}%, Inactive ${rate(grp("I"))}%. Renewal is automatic unless cancelled (${pct(count(y1rows, r=>r.y1&&r.y1a), count(y1rows, r=>r.y1))} of renewals), so the first renewal measures the absence of a cancellation; behaviour should show in cancellations and year 2.`
  ];
  document.getElementById("trends").innerHTML = items.map(t => `<li>${t}</li>`).join("");
}

