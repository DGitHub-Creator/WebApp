<%--
  ~ Copyright ©2022 WebApp/index.jsp Powered By DZX 2022/7/11
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
    ArrayList<String[]> list = connDb.index();
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
            <li class="current"><a href="#">所有买家各消费行为对比</a></li>
            <li><a href="./index1.jsp">男女买家交易对比</a></li>
            <li><a href="./index2.jsp">男女买家各个年龄段交易对比</a></li>
            <li><a href="./index3.jsp">商品类别交易额对比</a></li>
            <li><a href="./index4.jsp">各省份的总成交量对比</a></li>
        </ul>
    </div>
    <div class="container">
        <div class="title">所有买家各消费行为对比</div>
        <div class="show">
            <div class='chart-type'>饼图</div>
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
    option = {
        backgroundColor: '#2c343c',

        title: {
            text: '所有买家消费行为比例图',
            left: 'center',
            top: 20,
            textStyle: {
                color: '#ccc'
            }
        },

        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },

        legend: {
            orient: 'vertical',
            left: 'auto',
            data: ['特别关注', '购买', '添加购物车', '点击'],
            textStyle: {
                color: 'rgba(255, 255, 255, 0.3)'
            }
        },

        // visualMap: {
        //     show: false,
        //     min: 80,
        //     max: 600,
        //     // inRange: {
        //     //     // colorLightness: [0, 1]
        //     // }
        // },
        color: ['#5470c6', '#91cc75', '#fac858', '#ee6666', '#73c0de', '#3ba272', '#fc8452', '#9a60b4', '#ea7ccc'],
        series: [
            {
                name: '消费行为',
                type: 'pie',
                radius: '55%',
                center: ['50%', '50%'],
                data: [
                    {value:<%=list.get(0)[1]%>, name: '特别关注'},
                    {value:<%=list.get(1)[1]%>, name: '购买'},
                    {value:<%=list.get(2)[1]%>, name: '添加购物车'},
                    {value:<%=list.get(3)[1]%>, name: '点击'},
                ].sort(function (a, b) {
                    return a.value - b.value
                }),
                roseType: 'angle',
                label: {
                    normal: {
                        textStyle: {
                            color: 'rgba(255, 255, 255, 0.3)'
                        }
                    }
                },
                labelLine: {
                    normal: {
                        lineStyle: {
                            color: 'rgba(255, 255, 255, 0.3)'
                        },
                        smooth: 0.2,
                        length: 10,
                        length2: 20
                    }
                },
                itemStyle: {
                    normal: {
                        // color: '#c23531',
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                },

                animationType: 'scale',
                animationEasing: 'elasticOut',
                animationDelay: function (idx) {
                    return Math.random() * 200;
                }
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