<%--
  ~ Copyright ©2022 WebApp/index2.jsp Powered By DZX 2022/7/11
  --%>

<%--
  Created by IntelliJ IDEA.
  User: DZX
  Date: 2022/7/4
  Time: 下午 07:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="dbtaobao.connDb,java.util.*" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    ArrayList<String[]> list = connDb.index_2();
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
        #myChart {
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
            <li class="current"><a href="#">男女买家各个年龄段交易对比</a></li>
            <li><a href="./index3.jsp">商品类别交易额对比</a></li>
            <li><a href="./index4.jsp">各省份的总成交量对比</a></li>
        </ul>
    </div>
    <div class="container">
        <div class="title">男女买家各个年龄段交易对比</div>
        <div class="show">
            <div class='chart-type'>散点图</div>
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
    var data = [];
    data[0] = [];
    data[1] = [];
    <%
        for(String[] a:list){
            if(a[0].equals("0")){
    %>
    data[0].push([<%=a[1]%>, <%=a[2]%>, <%=a[2]%>]);
    <%
            }else if(a[0].equals("1")){
    %>
    data[1].push([<%=a[1]%>, <%=a[2]%>, <%=a[2]%>]);
    <%
            }
        }
    %>

    option = {
        backgroundColor: new echarts.graphic.RadialGradient(0.3, 0.3, 0.8, [{
            offset: 0,
            color: '#f7f8fa'
        }, {
            offset: 1,
            color: '#cdd0d5'
        }]),
        title: {
            text: '男女买家各个年龄段交易对比',
            left: 'center',
            top: 20,
        },
        legend: {
            right: 10,
            data: ['women', 'men']
        },

        xAxis: {
            name: '年龄段',
            nameTextStyle: { // x轴name的样式调整
                color: '#000',
                fontSize: 15,
            },
            nameGap: 25,  // x轴name与横坐标轴线的间距
            nameLocation: "middle", // x轴name处于x轴的什么位置
            splitLine: {
                lineStyle: {
                    type: 'dashed'
                }
            }
        },
        yAxis: {
            name: '成交量',
            nameTextStyle: {  // y轴name的样式调整
                color: '#000',
                fontSize: 15,
            },
            nameRotate: 90, // y轴name旋转90度 使其垂直
            nameGap: 35,  // y轴name与横纵坐标轴线的间距
            nameLocation: "middle", // y轴name处于y轴的什么位置
            splitLine: {
                lineStyle: {
                    type: 'dashed'
                }
            },
            scale: true
        },
        series: [{
            name: 'women',
            data: data[0],
            type: 'scatter',
            symbolSize: function (data) {
                return Math.sqrt(data[1]) / 2;
            },
            label: {
                emphasis: {
                    show: true,
                    formatter: function (param) {
                        return param.data[3];
                    },
                    position: 'top'
                }
            },
            itemStyle: {
                normal: {
                    shadowBlur: 10,
                    shadowColor: 'rgba(120, 36, 50, 0.5)',
                    shadowOffsetY: 5,
                    color: new echarts.graphic.RadialGradient(0.4, 0.3, 1, [{
                        offset: 0,
                        color: 'rgb(251, 118, 123)'
                    }, {
                        offset: 1,
                        color: 'rgb(204, 46, 72)'
                    }])
                }
            }
        }, {
            name: 'men',
            data: data[1],
            type: 'scatter',
            symbolSize: function (data) {
                return Math.sqrt(data[1]) / 2;
            },
            label: {
                emphasis: {
                    show: true,
                    formatter: function (param) {
                        return param.data[3];
                    },
                    position: 'top'
                }
            },
            itemStyle: {
                normal: {
                    shadowBlur: 10,
                    shadowColor: 'rgba(25, 100, 150, 0.5)',
                    shadowOffsetY: 5,
                    color: new echarts.graphic.RadialGradient(0.4, 0.3, 1, [{
                        offset: 0,
                        color: 'rgb(129, 227, 238)'
                    }, {
                        offset: 1,
                        color: 'rgb(25, 183, 207)'
                    }])
                }
            }
        }]
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