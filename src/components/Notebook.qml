import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

import Qt.labs.settings 1.0

import org.kde.kirigami 2.14 as Kirigami
import org.mauikit.controls 1.3 as Maui

import "."
Maui.Page
    {
        id: control

       background: Rectangle
        {
            width: pageWidth
            height: pageHeight
            color: bgColor
//            border.width: 0.5
//            border.color: squaresColor
/*            Column
            {
                Repeater
                {
                model: _canvas.height / squareSize
                    Row
                    {
                        Repeater
                        {
                            model: _canvas.width / squareSize
                            Rectangle
                            {
                                width: squareSize; height: squareSize
                                border.width: 0.5
                                border.color: squaresColor
                                color: bgColor
                            }
                        }
                    }
                }
            }*/
        }

        /**
        *
        */
        property var pageHeight: 3508
        property var pageWidth: 2480
        //property string squaresColor: "#FAEBD7"
        property string bgColor: "#FFFAF0"
        //property var squareSize: 15


        property var brushSize: 20
        property var brushOpacity: 1
        property var brushShape: 0 // 0 round, 1 rect
        property var maxBrushSize: 100
        property color paintColor: "blue"

        ScrollView
        {
            Layout.fillHeight: true
            Layout.fillWidth: true

            contentHeight: _canvas.height
            contentWidth: _canvas.width

            DrawCanvas
            {
                id: _canvas
                anchors.fill: parent
                width: control.pageWidth
                height: control.pageHeight
                brushSize: control.brushSize + control.brushShape * (control.brushSize * 10) * (1 - control.brushOpacity) // scale the highliter brush to the correct size
                brushOpacity : control.brushOpacity
                brushShape: control.brushShape
                maxBrushSize: control.brushSize
                paintColor: control.paintColor
            }

        }

        function save(destination)
        {
            // drawing the background in the "output" file
            var ctx = _canvas.buffer.getContext("2d")
            ctx.globalCompositeOperation = "destination-atop"
            ctx.fillStyle = bgColor
            ctx.fillRect(0, 0, pageWidth, pageHeight)
            buffer.requestPaint()
            buffer.save("prova.jpg")
        }
}
