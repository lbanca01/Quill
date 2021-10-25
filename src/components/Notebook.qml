import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

import Qt.labs.settings 1.0

import org.kde.kirigami 2.14 as Kirigami
import org.mauikit.controls 1.3 as Maui

import "."
Item
{
        id: control

        /**
        *
        */
        //property string squaresColor: "#FAEBD7"
        property string bgColor: "#FFFAF0"
        //property var squareSize: 15

        property var brushSize: 20
        property var brushOpacity: 1
        property var brushShape: 0 // 0 round, 1 rect
        property var maxBrushSize: 100
        property color paintColor: "blue"
        property real scale: 1
        property alias canvas: _canvas

        DrawCanvas
        {
            id: _canvas
            anchors.fill: parent
            height: height
            width: width
            brushSize: control.brushSize + control.brushShape * (control.brushSize * 10) * (1 - control.brushOpacity) // scale the highliter brush to the correct size
            brushOpacity : control.brushOpacity
            brushShape: control.brushShape
            maxBrushSize: control.brushSize
            paintColor: control.paintColor
            scale: control.scale
            bgColor: control.bgColor
        }

        function saveToFile(destination)
        {
            // drawing the background in the "output" file
            var ctx = _canvas.buffer.getContext("2d")
            ctx.globalCompositeOperation = "destination-atop"
            ctx.fillStyle = bgColor
            ctx.fillRect(0, 0, width, height)
            _canvas.buffer.requestPaint()
            _canvas.buffer.save(destination)
        }

}
