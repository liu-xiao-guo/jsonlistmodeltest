import QtQuick 2.0
import Ubuntu.Components 1.1

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "jsonlistmodeltest.liu-xiao-guo"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(100)
    height: units.gu(75)

    Page {
        title: i18n.tr("jsonlistmodeltest")

        Column {
            spacing: 5
            anchors.fill: parent
            anchors.margins: 5
            anchors.bottomMargin: 0

            Text {
                text: "JSON file data with subtree extraction: all books by title"
            }

            ListView {
                id: list1
                width: parent.width
                height: 200

                JSONListModel {
                    id: jsonModel1
                    source: "jsonData.txt"
                    query: "$.store.book[*]"
                }

                model: jsonModel1.model

                section.delegate: sectionDelegate
                section.property: "title"
                section.criteria: ViewSection.FirstCharacter

                delegate: Component {
                    Text {
                        width: parent.width
                        horizontalAlignment: Text.AlignLeft
                        font.pixelSize: 14
                        color: "black"
                        text: model.title

                        Text {
                            anchors.fill: parent
                            anchors.rightMargin: 5
                            horizontalAlignment: Text.AlignRight
                            font.pixelSize: 12
                            color: "gray"
                            text: model.author
                        }
                    }
                }
            }

            Text {
                text: "JSON file data with expression filter: books less than $10 by genre"
            }

            ListView {
                id: list2
                width: parent.width
                height: 200
                clip: true

                JSONListModel {
                    id: jsonModel2
                    source: "jsonData.txt"

                    query: "$..book[?(@.price<10)]"
                }
                model: jsonModel2.model

                section.delegate: sectionDelegate
                section.property: "category"
                section.criteria: ViewSection.FullString

                delegate: Component {
                    Text {
                        width: parent.width
                        horizontalAlignment: Text.AlignLeft
                        font.pixelSize: 14
                        color: "black"
                        text: model.title

                        Text {
                            anchors.fill: parent
                            anchors.rightMargin: 5
                            horizontalAlignment: Text.AlignRight
                            font.pixelSize: 12
                            color: "gray"
                            text: model.price
                        }
                    }
                }
            }

            Text {
                text: "JSON string data with substring filter: labels starting with 'A'"
            }
            ListView {
                id: list3
                width: parent.width
                height: 100
                clip: true

                JSONListModel {
                    id: jsonModel3
                    json: '[ \
                    {"label": "Answer", "value": "42"}, \
                    {"label": "Pastis", "value": "51"}, \
                    {"label": "Alsace", "value": "67"}, \
                    {"label": "Alsace", "value": "68"} \
                    ]'

                    query: "$[?(@.label.charAt(0)==='A')]"

                }
                model: jsonModel3.model

                delegate: Component {
                    Text {
                        width: parent.width
                        horizontalAlignment: Text.AlignLeft
                        font.pixelSize: 20
                        color: "black"
                        text: model.label

                        Text {
                            anchors.fill: parent
                            anchors.rightMargin: 5
                            horizontalAlignment: Text.AlignRight
                            font.pixelSize: 18
                            color: "gray"
                            text: model.value
                        }
                    }
                }
            }
        }

        Component {
            id: sectionDelegate
            Rectangle {
                color: "gray"
                width: parent.width
                height: sectionLabel.height
                Text {
                    id: sectionLabel
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                    font.pixelSize: 20
                    color: "white"
                    style: Text.Raised
                    text: section
                }
            }
        }
    }
}

