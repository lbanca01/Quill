import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

import Qt.labs.settings 1.0

import org.kde.kirigami 2.14 as Kirigami
import org.mauikit.controls 1.3 as Maui

Maui.Page
    {
        id: control

        Kirigami.Theme.backgroundColor: Qt.rgba(bgColor.r, bgColor.g, bgColor.b, 0.85)
        Kirigami.Theme.textColor:"#fefefe"
        //     deafultButtons: false

        /**
        *
        */
        property Item sourceItem : null

        /**
        *
        */
        readonly property color bgColor : "#ff0000"

        /**
        *
        */
        property alias brushSize : _canvas.brushSize

        /**
        *
        */
        property alias brushOpacity : _canvas.brushOpacity

        /**
        *
        */
        property alias brushShape : _canvas.brushShape //0 -Circular, 1 - rectangular.

        /**
        *
        */
        property alias maxBrushSize: _canvas.maxBrushSize

        /**
        *
        */
        property alias paintColor: _canvas.paintColor
        footBar.visible: true

        footBar.rightContent: ToolButton
        {
            icon.name: "document-share"
            onClicked: {}
        }

        footBar.leftContent: Maui.ToolActions
        {
            expanded: true
            autoExclusive: true
            checkable: false

            Action
            {
                icon.name: "edit-undo"
            }

            Action
            {
                icon.name: "edit-redo"
            }
        }


        footBar.middleContent:[

            Maui.ToolActions
            {
                autoExclusive: true
                expanded: true
                display: ToolButton.TextBesideIcon

                Action
                {
                    icon.name: "draw-highlight"
                    text: i18n("Highlighter")
                    onTriggered:
                    {
                        control.paintColor = "yellow"
                        control.brushShape = 1
                    }
                }

                Action
                {
                    icon.name: "draw-brush"
                    text: i18n("Marker")
                    onTriggered:
                    {
                        control.paintColor = "blue"
                        control.brushShape = 0
                    }
                }

                Action
                {
                    icon.name: "draw-calligraphic"
                    text: i18n("Highlighter")
                    onTriggered:
                    {
                        control.paintColor = "#333"
                        control.brushShape = 1
                    }
                }

                Action
                {
                    id: _eraserButton
                    text: i18n("Eraser")

                    icon.name: "draw-eraser"
                }
            },

            Maui.ToolActions
            {
                expanded: true
                autoExclusive: false
                display: ToolButton.TextBesideIcon

                Action
                {
                    id: _colorsButton
                    text: i18n("Color")
                    icon.name: "color-fill"
                }

                Action
                {
                    id: _opacityButton
                    text: i18n("Opacity")

                    icon.name: "edit-opacity"
                }

                Action
                {
                    id: _sizeButton
                    text: i18n("Size")

                }
            }

        ]

        headBar.visible: false


        ScrollView
        {
            Layout.fillHeight: true
            Layout.fillWidth: true

            contentHeight: img.height
            contentWidth: img.width

            Image
            {

                id: img
                height: 500
                width: 500
                autoTransform: true
                asynchronous: true
                anchors.centerIn: parent

        }

            Maui.DoodleCanvas
            {
                id: _canvas
                anchors.fill: parent
                brushSize : 16
               // brushOpacity :_opacitySlider.value
            }
        }
    }
