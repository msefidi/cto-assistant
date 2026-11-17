"""Build assets/fomf-vorlage.docx for the sponsor-briefing skill, then render a sample briefing into it."""
import sys
from html.parser import HTMLParser
from docx import Document
from docx.enum.style import WD_STYLE_TYPE
from docx.enum.text import WD_TAB_ALIGNMENT
from docx.oxml import parse_xml
from docx.oxml.ns import nsdecls, qn
from docx.shared import Cm, Pt, RGBColor

NAVY, TEAL, TEAL_TEXT, BODY, MUTED = "12385C", "019ABC", "0185A2", "4A4A68", "71889D"
FONT = "Arial"


def rgb(h):
    return RGBColor.from_string(h)


def set_font(style, size, color, bold=None):
    style.font.name = FONT
    style.element.rPr.rFonts.set(qn("w:eastAsia"), FONT)
    style.font.size = Pt(size)
    style.font.color.rgb = rgb(color)
    if bold is not None:
        style.font.bold = bold


def add_field(paragraph, instr):
    run = paragraph.add_run()
    run._r.append(parse_xml(f'<w:fldChar {nsdecls("w")} w:fldCharType="begin"/>'))
    run._r.append(parse_xml(f'<w:instrText {nsdecls("w")} xml:space="preserve"> {instr} </w:instrText>'))
    run._r.append(parse_xml(f'<w:fldChar {nsdecls("w")} w:fldCharType="end"/>'))
    return run


def build(logo, out):
    doc = Document()
    sec = doc.sections[0]
    sec.page_width, sec.page_height = Cm(21), Cm(29.7)
    sec.left_margin = sec.right_margin = Cm(2)
    sec.top_margin, sec.bottom_margin = Cm(2.4), Cm(2)
    sec.header_distance, sec.footer_distance = Cm(1), Cm(1)

    st = doc.styles
    normal = st["Normal"]
    set_font(normal, 9.5, BODY)
    normal.paragraph_format.space_after = Pt(3)
    normal.paragraph_format.line_spacing = 1.15

    title = st["Title"]
    set_font(title, 18, NAVY, bold=True)
    title.paragraph_format.space_after = Pt(2)
    # Title has a theme border and colour in the default template; drop them
    for el in title.element.pPr.findall(qn("w:pBdr")):
        title.element.pPr.remove(el)

    sub = st["Subtitle"]
    set_font(sub, 8.5, MUTED, bold=False)
    sub.font.italic = False
    sub.paragraph_format.space_after = Pt(2)

    h1 = st["Heading 1"]
    set_font(h1, 12, NAVY, bold=True)
    h1.paragraph_format.space_before = Pt(10)
    h1.paragraph_format.space_after = Pt(3)
    h1.element.get_or_add_pPr().append(parse_xml(
        f'<w:pBdr {nsdecls("w")}><w:bottom w:val="single" w:sz="8" w:space="1" w:color="{TEAL}"/></w:pBdr>'))

    h2 = st["Heading 2"]
    set_font(h2, 10, TEAL_TEXT, bold=True)
    h2.paragraph_format.space_before = Pt(6)
    h2.paragraph_format.space_after = Pt(2)

    for name in ("List Bullet", "List Number"):
        set_font(st[name], 9.5, BODY)
        st[name].paragraph_format.space_after = Pt(2)

    hint = st.add_style("Hinweis", WD_STYLE_TYPE.PARAGRAPH)
    hint.base_style = normal
    set_font(hint, 8, MUTED)

    tbl = st.add_style("FOMF Tabelle", WD_STYLE_TYPE.TABLE)
    tbl.base_style = st["Normal Table"]
    tbl.element.append(parse_xml(
        f'<w:pPr {nsdecls("w")}><w:spacing w:before="20" w:after="20"/></w:pPr>'))
    tbl.element.append(parse_xml(
        f'<w:rPr {nsdecls("w")}><w:sz w:val="17"/></w:rPr>'))
    border = f'w:val="single" w:sz="4" w:space="0" w:color="D9DBE9"'
    tbl.element.append(parse_xml(
        f'<w:tblPr {nsdecls("w")}><w:tblBorders><w:top {border}/><w:left {border}/><w:bottom {border}/>'
        f'<w:right {border}/><w:insideH {border}/><w:insideV {border}/></w:tblBorders>'
        f'<w:tblCellMar><w:left w:w="80" w:type="dxa"/><w:right w:w="80" w:type="dxa"/></w:tblCellMar></w:tblPr>'))
    tbl.element.append(parse_xml(
        f'<w:tblStylePr {nsdecls("w")} w:type="firstRow"><w:rPr><w:b/><w:color w:val="{NAVY}"/></w:rPr>'
        f'<w:tcPr><w:shd w:val="clear" w:color="auto" w:fill="E3F6FC"/></w:tcPr></w:tblStylePr>'))

    hp = sec.header.paragraphs[0]
    hp.paragraph_format.tab_stops.add_tab_stop(Cm(17), WD_TAB_ALIGNMENT.RIGHT)
    hp.add_run().add_picture(logo, width=Cm(2.6))
    r = hp.add_run("\tSponsor-Briefing · intern")
    r.font.size, r.font.color.rgb = Pt(8), rgb(MUTED)

    fp = sec.footer.paragraphs[0]
    fp.paragraph_format.tab_stops.add_tab_stop(Cm(17), WD_TAB_ALIGNMENT.RIGHT)
    for text, field in (("FOMF · intern · Ohne Preise und Beträge\tSeite ", None), (None, "PAGE")):
        run = fp.add_run(text) if text else add_field(fp, field)
        run.font.size, run.font.color.rgb = Pt(8), rgb(MUTED)

    doc.save(out)


def style_table(t):
    """Direct borders as well as the table style, for viewers that ignore table styles."""
    border = 'w:val="single" w:sz="4" w:space="0" w:color="D9DBE9"'
    t._tbl.tblPr.append(parse_xml(
        f'<w:tblBorders {nsdecls("w")}><w:top {border}/><w:left {border}/><w:bottom {border}/>'
        f'<w:right {border}/><w:insideH {border}/><w:insideV {border}/></w:tblBorders>'))


class Renderer(HTMLParser):
    """Maps the skill's simple briefing HTML onto the template's styles."""

    def __init__(self, doc):
        super().__init__()
        self.doc, self.par, self.bold, self.italic = doc, None, False, False
        self.lists, self.table, self.row, self.cell, self.skip = [], None, None, None, False

    def new_par(self, style):
        self.par = self.doc.add_paragraph(style=style)

    def handle_starttag(self, tag, attrs):
        cls = dict(attrs).get("class", "")
        if tag in ("style", "title"):
            self.skip = True
        elif tag == "h1":
            self.new_par("Title")
        elif tag == "h2":
            self.new_par("Heading 1")
        elif tag == "h3":
            self.new_par("Heading 2")
        elif tag == "p" and self.cell is None:
            self.new_par("Subtitle" if cls == "meta" else "Hinweis" if cls == "hint" else "Normal")
        elif tag in ("ul", "ol"):
            self.lists.append("List Bullet" if tag == "ul" else "List Number")
        elif tag == "li":
            self.new_par(self.lists[-1])
        elif tag == "table":
            self.table = []
        elif tag == "tr":
            self.row = []
        elif tag in ("td", "th"):
            self.cell = [];
        elif tag == "b":
            self.bold = True
        elif tag == "i":
            self.italic = True

    def handle_endtag(self, tag):
        if tag in ("style", "title"):
            self.skip = False
        elif tag in ("ul", "ol"):
            self.lists.pop()
        elif tag in ("td", "th"):
            self.row.append(self.cell)
            self.cell = None
        elif tag == "tr":
            self.table.append(self.row)
        elif tag == "table":
            rows = self.table
            t = self.doc.add_table(rows=len(rows), cols=max(len(r) for r in rows), style="FOMF Tabelle")
            style_table(t)
            for i, r in enumerate(rows):
                for j, runs in enumerate(r):
                    if i == 0:
                        t.cell(i, j)._tc.get_or_add_tcPr().append(parse_xml(
                            f'<w:shd {nsdecls("w")} w:val="clear" w:color="auto" w:fill="E3F6FC"/>'))
                    p = t.cell(i, j).paragraphs[0]
                    for text, b, it in runs:
                        run = p.add_run(text)
                        run.bold, run.italic = b or None, it or None
            self.table = None
        elif tag == "b":
            self.bold = False
        elif tag == "i":
            self.italic = False

    def handle_data(self, data):
        if self.skip or not data.strip() and self.cell is None and self.par is None:
            return
        text = " ".join(data.split()) if data.strip() else " "
        if data[:1].isspace() and data.strip():
            text = " " + text
        if data[-1:].isspace() and data.strip():
            text = text + " "
        if self.cell is not None:
            self.cell.append((text, self.bold, self.italic))
        elif self.par is not None and data.strip() or (self.par is not None and self.par.runs):
            run = self.par.add_run(text)
            run.bold, run.italic = self.bold or None, self.italic or None


def render(template, html_path, out):
    doc = Document(template)
    body = doc.element.body
    for p in list(body.iterchildren(qn("w:p"))):
        body.remove(p)
    r = Renderer(doc)
    r.feed(open(html_path, encoding="utf-8").read())
    for p in doc.paragraphs:
        if p.runs:
            p.runs[0].text = p.runs[0].text.lstrip()
            p.runs[-1].text = p.runs[-1].text.rstrip()
    doc.save(out)


if __name__ == "__main__":
    if sys.argv[1] == "build":
        build(sys.argv[2], sys.argv[3])
    else:
        render(sys.argv[2], sys.argv[3], sys.argv[4])
