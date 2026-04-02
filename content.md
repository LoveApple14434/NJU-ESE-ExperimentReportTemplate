---
name: "张三李四"
id: "231180000"
major: "神秘专业"
grade: "2023级"
course: "神秘课程"
semst: "2000-2001 学年第一学期"
exp_name: "神秘的神秘实验"
time: "13 月 32、39、46 日"
room: "北大楼 101"
teacher: "水煮鱼"
packages: "graphicx,amsmath,amssymb,amsthm,fancyhdr,needspace,geometry,xeCJK"
optional_packages: "booktabs,longtable,listings,subfig"
booktabs: true
pandoc-crossref:
  subfigures: true
  subfigure-numbering: true
figPrefix: "图"
tblPrefix: "表"
eqnPrefix: "公式"
---

# 测试一级标题

## 测试二级标题

### 测试三级标题

#### 测试四级标题

测试正文

![测试图片](fig/2.4.jpg){#fig:test_fig}

# 测试一级标题*2

![测试图片2：测试图片编号](fig/2.4.jpg){}

$$
F=\int \frac{Gm_1m_2}{r^2} dr
$$
{#eq:test_equation}

测试交叉引用 @fig:test_fig , @eq:test_equation 以及 @tbl:test_tab 。注意引用前后要有空格！

|name|value|
|---|---|
|123|456|
:caption 表格标题{#tbl:test_tab}


```{.python .number-lines startFrom="10"}
print("Hello, world!")
```

如果你想在同一行里放多张图片，也许只能硬写LaTeX了？

\begin{figure}
    \begin{minipage}{0.49\linewidth}
        \centering
        \includegraphics[width=\columnwidth]{fig/2.4.jpg}
        \caption{左图}
    \end{minipage}
    \begin{minipage}{0.49\linewidth}
        \centering
        \includegraphics[width=\columnwidth]{fig/2.4.jpg}
        \caption{右图}
    \end{minipage}
\end{figure}