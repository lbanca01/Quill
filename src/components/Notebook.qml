import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

import Qt.labs.settings 1.0

import org.kde.kirigami 2.14 as Kirigami
import org.mauikit.controls 1.3 as Maui

import org.maui.kuill 1.0

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
        property alias list: _pages
        property int count: 0
        property var pageWidth: 1
        property var pageHeight: 1
/*
        Rectangle{
            width: 50
            height: 50
            color: "red"
            id: test
        }
*/
        Maui.ListBrowser
        {
            id: _list
            spacing: Maui.Style.space.big //+ control.pageHeight * control.scale
            anchors.fill: parent

            model: Maui.BaseModel
            {

                id: _model
                list: PagesList
                {
                    id: _pages
                }
                sort: "n"
                sortOrder: Qt.AscendingOrder
            }

            delegate: Maui.ItemDelegate
            {
                hoverEnabled: false
                anchors.horizontalCenter: parent.horizontalCenter

                transformOrigin: Item.Top

                width: control.pageWidth * control.scale
                height: control.pageHeight * control.scale

                DrawCanvas
                {
                    id: _canvas
                    transformOrigin: Item.Top
                    property bool ciao: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: control.pageWidth
                    height: control.pageHeight
                    brushSize: control.brushSize + control.brushShape * (control.brushSize * 10) * (1 - control.brushOpacity) // scale the highliter brush to the correct size
                    brushOpacity : control.brushOpacity
                    brushShape: control.brushShape
                    maxBrushSize: control.brushSize
                    paintColor: control.paintColor
                    scale: control.scale
                    bgColor: control.bgColor
                }
            }

        }

        function saveToFile(destination)
        {
            // drawing the background in the "output" file

            if (_pages.get(0)){
                test.color = "blue"
            }
            ctx.globalCompositeOperation = "destination-atop"
            ctx.fillStyle = bgColor
            ctx.fillRect(0, 0, pageWidth, pageHeight)
            _canvas.buffer.requestPaint()
            _canvas.buffer.save(destination)
        }

        function addPage()
        {
            _pages.append({"n" : count})
            count += 1
        }

        function removePage()
        {
            _pages.remove(count - 1)
            count -= 1
        }
}
