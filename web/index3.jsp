<%--
  ~ Copyright ©2022 WebApp/index3.jsp Powered By DZX 2022/7/4
  --%>

<%--
  Created by IntelliJ IDEA.
  User: DZX
  Date: 2022/7/4
  Time: 下午 07:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="dbtaobao.connDb,java.util.*" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    ArrayList<String[]> list = connDb.index_3();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>ECharts 可视化分析淘宝双11</title>
    <link href="./css/style.css" type='text/css' rel="stylesheet"/>
    <script src="js/echarts.js"></script>
    <style type="text/css">
        html, body {
            width: 100%;
            height: 90%;
            margin: 0;
            padding: 0;
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
            <li class="current"><a href="#">商品类别交易额对比</a></li>
            <li><a href="./index4.jsp">各省份的总成交量对比</a></li>
        </ul>
    </div>
    <div class="container">
        <div class="title">商品类别交易额对比</div>
        <div class="show">
            <div class='chart-type'>柱状图</div>
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
    //基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));
    // 指定图表的配置项和数据
    var x = []
    var y = []
    <%
        for(String[] a:list){
            %>
    x.push(<%=a[0]%>);
    y.push(<%=a[1]%>);
    <%
}
%>
    option = {
        color: ['#3398DB'],
        tooltip : {
            trigger: 'axis',
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        title: {
            text: '商品类别交易额对比',
            left: 'center',
            top: 20,
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis : [
            {
                name: '商品类别',
                nameTextStyle: { // x轴name的样式调整
                    color: '#000',
                    fontSize: 13,
                },
                nameGap: 22,  // x轴name与横坐标轴线的间距
                nameLocation: "middle", // x轴name处于x轴的什么位置
                type : 'category',
                data : x,
                axisTick: {
                    alignWithLabel: true
                }
            }
        ],
        yAxis : [
            {
                name: '交易额',
                nameTextStyle: {  // y轴name的样式调整
                    color: '#000',
                    fontSize: 13,
                },
                nameRotate: 90, // y轴name旋转90度 使其垂直
                nameGap: 35,  // y轴name与横纵坐标轴线的间距
                nameLocation: "middle", // y轴name处于y轴的什么位置
                type : 'value'
            }
        ],
        series : [
            {
                name:'交易额',
                type:'bar',
                barWidth: '60%',
                data:y
            }
        ]
    };
    // 使用刚指定的配置项和数据显示图表。
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