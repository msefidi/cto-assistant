"""Postal mailing economics, 1 Jan – 22 Sep of 2024, 2025, 2026 (DACH). Reads data/*.tsv, writes data/pa.json."""
import csv, json, collections as C
rd=lambda p: list(csv.DictReader(open(p),delimiter='\t'))
# LTV lookup: 24-month cash value by entry x stage x specialty; cells < 30 fall back to entry x stage
L=rd('data/ltv_by_segment.tsv'); cell={}; agg=C.defaultdict(lambda:[0,0.0,0.0])
for r in L:
    n=int(r['customers']); k=(r['kind'],r['stage'])
    cell[(r['kind'],r['stage'],r['spec'])]=(n,float(r['ltv24']),float(r['ltv12']))
    a=agg[k]; a[0]+=n; a[1]+=n*float(r['ltv24']); a[2]+=n*float(r['ltv12'])
def ltv(kind,stage,spec,which=1):
    c=cell.get((kind,stage,spec))
    if c and c[0]>=30: return c[which]
    a=agg[(kind,stage)]; return a[which]/a[0]
POSTAL='Print: postal flyer'
YEARS=[2024,2025,2026]; PER=['A','B','C']
res={}
for y in YEARS:
    R=rd(f'data/window_{y}.tsv')
    cells=C.defaultdict(lambda:{'s':C.Counter(),'sv':C.Counter(),'m':0,'mv':0.0,'mseg':C.Counter(),'sseg':C.Counter()})
    for r in R:
        k=(r['period'],r['month'],r['country']); c=cells[k]; n=int(r['customers'])
        v=n*ltv(r['kind'],r['stage'],r['spec'])
        if r['kind']=='Membership' or r['channel']=='Membership':
            c['m']+=n; c['mv']+=v; c['mseg'][(r['stage'],r['spec'],'Membership')]+=n
        else:
            c['s'][r['channel']]+=n; c['sv'][r['channel']]+=v
            if r['channel']==POSTAL: c['sseg'][(r['stage'],r['spec'],'Single course')]+=n
    out={p:{'all':0,'all_v':0.0,'single':0,'mem':0,'post':0.0,'post_v':0.0,'post_single':0,'post_mem':0.0,'seg':C.Counter(),'segv':C.Counter()} for p in PER}
    for (p,mo,ct),c in cells.items():
        o=out[p]; ns=sum(c['s'].values())
        o['all']+=ns+c['m']; o['all_v']+=sum(c['sv'].values())+c['mv']; o['single']+=ns; o['mem']+=c['m']
        base={ch:v for ch,v in c['s'].items() if ch!='(no answer)'}; tot=sum(base.values())
        share=base.get(POSTAL,0)/tot if tot else 0
        o['post_single']+=c['s'][POSTAL]; o['post_mem']+=c['m']*share
        o['post']+=c['s'][POSTAL]+c['m']*share; o['post_v']+=c['sv'][POSTAL]+c['mv']*share
        for sg,n in c['sseg'].items(): o['seg'][sg]+=n; o['segv'][sg]+=n*ltv(sg[2],sg[0],sg[1])
        for sg,n in c['mseg'].items(): o['seg'][sg]+=n*share; o['segv'][sg]+=n*share*ltv(sg[2],sg[0],sg[1])
    res[y]=out
# print summary
lab={'A':'Jan–May','B':'1 Jun–17 Aug','C':'18 Aug–22 Sep'}
for p in PER:
    print(lab[p])
    for y in YEARS:
        o=res[y][p]; print(f"  {y}: all {o['all']:5} (S {o['single']}, M {o['mem']})  LTV {o['all_v']/1e3:7.0f}k | postal {o['post']:6.0f} (S {o['post_single']}, M {o['post_mem']:.0f}) LTV {o['post_v']/1e3:6.0f}k")
json.dump({str(y):{p:{k:(v if not isinstance(v,C.Counter) else {'|'.join(kk):vv for kk,vv in v.items()}) for k,v in o.items()} for p,o in res[y].items()} for y in res},open('data/pa.json','w'))
