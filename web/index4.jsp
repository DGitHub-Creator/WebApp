<%--
  ~ Copyright ©2022 WebApp/index4.jsp Powered By DZX 2022/7/4
  --%>

<%--
  Created by IntelliJ IDEA.
  User: DZX
  Date: 2022/7/4
  Time: 下午 07:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="dbtaobao.connDb,java.util.*" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    ArrayList<String[]> list = connDb.index_4();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>ECharts 可视化分析淘宝双11</title>
    <link href="./css/style.css" type='text/css' rel="stylesheet"/>
    <script src="js/echarts.js"></script>
    <script src="js/china.js"></script>
    <style type="text/css">
        html, body {
            width: 100%;
            height: 90%;
            margin: 0;
            padding: 0;
        }
        #main {
            width: 90%;
            min-height: 80%;
        }
    </style>
</head>
<body>
<div class='header'>
    <p>ECharts 可视化分析淘宝双11</p>
</div>
<div class="content">
    <div class="nav">
        <ul>
            <li><a href="./index.jsp">所有买家各消费行为对比</a></li>
            <li><a href="./index1.jsp">男女买家交易对比</a></li>
            <li><a href="./index2.jsp">男女买家各个年龄段交易对比</a></li>
            <li><a href="./index3.jsp">商品类别交易额对比</a></li>
            <li class="current"><a href="#">各省份的总成交量对比</a></li>
        </ul>
    </div>
    <div class="container">
        <div class="title">各省份的总成交量对比</div>
        <div class="show">
            <div class='chart-type'>地图</div>
            <div id="main"></div>
        </div>
    </div>
</div>
<script>
    var worldMapContainer = document.getElementById('main');
    //用于使chart自适应高度和宽度,通过窗体高宽计算容器高宽
    var resizeWorldMapContainer = function () {
        worldMapContainer.style.width = 0.77*window.innerWidth + 'px';
        worldMapContainer.style.height = 0.7*window.innerHeight + 'px';
    };
    //设置容器高宽
    resizeWorldMapContainer();

    document.write(worldMapContainer.style.width);
    document.write(worldMapContainer.style.height);

    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    var data = [];
    <%
    for(String[] a:list){
    %>
    <%
    if (a[0].lastIndexOf('市') != -1)
        a[0] = a[0].substring(0, a[0].lastIndexOf('市'));
    %>
    data.push({name: "<%=a[0]%>", value:<%=a[1]%>});
    <%
    }
    %>

    // 指定图表的配置项和数据
    option = {
        title: {
            text: "各省份的总成交量",
            left: 'center',
            top: 20,
        },
        tooltip: {
            trigger: "item",
        },
        legend: {
            orient: "vertical",
            left: "left",
            data: ["各省份的总成交量"],
        },
        visualMap: {
            left: 'right',
            min: 200,
            max: 400,
            inRange: {
                color: [
                    '#313695',
                    '#4575b4',
                    '#74add1',
                    '#abd9e9',
                    '#e0f3f8',
                    '#ffffbf',
                    '#fee090',
                    '#fdae61',
                    '#f46d43',
                    '#d73027',
                    '#a50026'
                ]
            },
            text: ['400', '200'],
            calculable: true
        },
        toolbox: {
            show: true,
            orient: "vertical",
            left: "right",
            top: "center",
            feature: {
                mark: {show: true},
                dataView: {show: true, readOnly: false},
                restore: {show: true},
                saveAsImage: {show: true},
            },
        },
        roamController: {
            show: true,
            left: "right",
            mapTypeControl: {
                china: true,
            },
        },
        series: [
            {
                name: "成交量",
                type: "map",
                mapType: "china",
                roam: false,
                label: {
                    show: true,
                    color: "rgb(249, 249, 249)",
                },
                data: data,
            },
        ],
    };

    //使用指定的配置项和数据显示图表
    myChart.setOption(option);

    //用于使chart自适应高度和宽度
    window.onresize = function () {
        //重置容器高宽
        resizeWorldMapContainer();
        myChart.resize();
    };


</script>
</body>
</html>