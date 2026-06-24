import QtQuick 2.15
import QtQuick3D 1.15
//import QtQuick.Timeline 1.1

Node {
    id: sketchfab_model
    eulerRotation.x: -90

    Node {
        id: sHAHED_PAINT_fbx
        eulerRotation.x: 90
        scale.x: 0.01
        scale.y: 0.01
        scale.z: 0.01

        Node {
            id: object_2

            Node {
                id: rootNode

                Node {
                    id: null_
                    y: 1.38778e-17
                    z: 377.624
                    eulerRotation.x: 180

                    Node {
                        id: polygon_16
                        x: -24.2867
                        y: 14.3567
                        z: 1.7053e-13
                        eulerRotation.y: 90
                        eulerRotation.z: -165
                        scale.x: 0.611902
                        scale.y: 0.56648
                        scale.z: 0.554955

                        Model {
                            id: polygon_16__Color_001_1_0
                            source: "meshes/polygon_16__Color_001_1_0.mesh"

                            PrincipledMaterial {
                                id: color_0011_material
                                baseColor: "#ffe2e2e2"
                                metalness: 0
                                roughness: 0.952432
                                cullMode: Material.NoCulling
                            }
                            materials: [
                                color_0011_material
                            ]
                        }

                        Model {
                            id: polygon_16__Color_M06__1
                            source: "meshes/polygon_16__Color_M06__1.mesh"

                            PrincipledMaterial {
                                id: color_M06_material
                                baseColor: "#ff565656"
                                metalness: 0
                                roughness: 0.952432
                                cullMode: Material.NoCulling
                            }
                            materials: [
                                color_M06_material
                            ]
                        }
                    }

                    Node {
                        id: polygon_15
                        x: 67.8679
                        y: -71.9836
                        z: -21.0596
                        eulerRotation.x: 90
                        eulerRotation.y: 5.10773
                        eulerRotation.z: 46.8555
                        scale.x: 0.426312
                        scale.y: 0.611563
                        scale.z: 0.410082

                        Model {
                            id: polygon_15__Steel_Brushed_Stainless__1
                            source: "meshes/polygon_15__Steel_Brushed_Stainless__1.mesh"

                            PrincipledMaterial {
                                id: steel_Brushed_Stainless_material
                                baseColor: "#ffcccccc"
                                metalness: 0
                                roughness: 0.952432
                                cullMode: Material.NoCulling
                            }
                            materials: [
                                steel_Brushed_Stainless_material
                            ]
                        }

                        Model {
                            id: polygon_15_Lisanne_Hammer_0
                            source: "meshes/polygon_15_Lisanne_Hammer_0.mesh"

                            PrincipledMaterial {
                                id: lisanne_Hammer_material
                                baseColor: "#ff3c4046"
                                metalness: 0
                                roughness: 0.952432
                                cullMode: Material.NoCulling
                            }
                            materials: [
                                lisanne_Hammer_material
                            ]
                        }
                    }

                    Node {
                        id: polygon_12
                        x: -68.0968
                        y: 72.1196
                        z: -21.0596
                        eulerRotation.x: 90
                        eulerRotation.y: 5.10773
                        eulerRotation.z: -133.145
                        scale.x: 0.426312
                        scale.y: 0.611563
                        scale.z: 0.410082

                        Model {
                            id: polygon_12__Steel_Brushed_Stainless__1
                            source: "meshes/polygon_12__Steel_Brushed_Stainless__1.mesh"
                            materials: [
                                steel_Brushed_Stainless_material
                            ]
                        }

                        Model {
                            id: polygon_12_Lisanne_Hammer_0
                            source: "meshes/polygon_12_Lisanne_Hammer_0.mesh"
                            materials: [
                                lisanne_Hammer_material
                            ]
                        }
                    }
                }

                Node {
                    id: sHAHED_PAINT_obj

                    Node {
                        id: wIBGS

                        Model {
                            id: wIBGS_default_0
                            source: "meshes/wIBGS_default_0.mesh"

                            PrincipledMaterial {
                                id: default_material
                                baseColorMap: Texture {
                                    source: "maps/0.png"
                                    tilingModeHorizontal: Texture.Repeat
                                    tilingModeVertical: Texture.Repeat
                                }
                                opacityChannel: Material.A
                                metalnessMap: Texture {
                                    source: "maps/1.png"
                                    tilingModeHorizontal: Texture.Repeat
                                    tilingModeVertical: Texture.Repeat
                                }
                                metalnessChannel: Material.B
                                roughnessMap: Texture {
                                    source: "maps/1.png"
                                    tilingModeHorizontal: Texture.Repeat
                                    tilingModeVertical: Texture.Repeat
                                }
                                roughnessChannel: Material.G
                                metalness: 0
                                roughness: 0.943431
                                normalMap: Texture {
                                    source: "maps/2.png"
                                    tilingModeHorizontal: Texture.Repeat
                                    tilingModeVertical: Texture.Repeat
                                }
                                cullMode: Material.NoCulling
                            }
                            materials: [
                                default_material
                            ]
                        }
                    }

                    Node {
                        id: w_T

                        Model {
                            id: w_T_default_0
                            source: "meshes/w_T_default_0.mesh"
                            materials: [
                                default_material
                            ]
                        }
                    }

                    Node {
                        id: w

                        Model {
                            id: w_default_0
                            source: "meshes/w_default_0.mesh"
                            materials: [
                                default_material
                            ]
                        }
                    }

                    Node {
                        id: bODY

                        Model {
                            id: bODY_default_0
                            source: "meshes/bODY_default_0.mesh"
                            materials: [
                                default_material
                            ]
                        }
                    }
                }
            }
        }
    }

//    Timeline {
//        id: timeline0
//        startFrame: 0
//        endFrame: 3000
//        currentFrame: 0
//        enabled: true
//        animations: [
//            TimelineAnimation {
//                duration: 3000
//                from: 0
//                to: 3000
//                running: true
//            }
//        ]

//        KeyframeGroup {
//            target: null_
//            property: "position"

//            Keyframe {
//                frame: 0
//                value: Qt.vector3d(0, 1.38778e-17, 377.624)
//            }
//        }

//        KeyframeGroup {
//            target: null_
//            property: "eulerRotation"

//            Keyframe {
//                frame: 0
//                value: Qt.vector3d(7.01671e-15, 180, 180)
//            }
//            Keyframe {
//                frame: 33.3333
//                value: Qt.vector3d(-1.21844e-15, -180, -80)
//            }
//            Keyframe {
//                frame: 66.6667
//                value: Qt.vector3d(-6.59355e-15, 180, 20)
//            }
//            Keyframe {
//                frame: 100
//                value: Qt.vector3d(3.50835e-15, 180, 120)
//            }
//            Keyframe {
//                frame: 133.333
//                value: Qt.vector3d(5.37511e-15, -180, -140)
//            }
//            Keyframe {
//                frame: 166.667
//                value: Qt.vector3d(-5.37511e-15, -180, -40)
//            }
//            Keyframe {
//                frame: 200
//                value: Qt.vector3d(-3.50835e-15, 180, 60)
//            }
//            Keyframe {
//                frame: 233.333
//                value: Qt.vector3d(6.59355e-15, 180, 160)
//            }
//            Keyframe {
//                frame: 266.667
//                value: Qt.vector3d(1.21844e-15, -180, -100)
//            }
//            Keyframe {
//                frame: 300
//                value: Qt.vector3d(-7.01671e-15, -180, -3.24611e-14)
//            }
//            Keyframe {
//                frame: 333.333
//                value: Qt.vector3d(1.21844e-15, 180, 100)
//            }
//            Keyframe {
//                frame: 366.667
//                value: Qt.vector3d(6.59355e-15, -180, -160)
//            }
//            Keyframe {
//                frame: 400
//                value: Qt.vector3d(-3.50835e-15, -180, -60)
//            }
//            Keyframe {
//                frame: 433.333
//                value: Qt.vector3d(-5.37511e-15, 180, 40)
//            }
//            Keyframe {
//                frame: 466.667
//                value: Qt.vector3d(5.37511e-15, 180, 140)
//            }
//            Keyframe {
//                frame: 500
//                value: Qt.vector3d(3.50835e-15, -180, -120)
//            }
//            Keyframe {
//                frame: 533.333
//                value: Qt.vector3d(-6.59355e-15, -180, -20)
//            }
//            Keyframe {
//                frame: 566.667
//                value: Qt.vector3d(-1.21844e-15, 180, 80)
//            }
//            Keyframe {
//                frame: 600
//                value: Qt.vector3d(7.01671e-15, 180, 180)
//            }
//            Keyframe {
//                frame: 633.333
//                value: Qt.vector3d(-1.21844e-15, -180, -80)
//            }
//            Keyframe {
//                frame: 666.667
//                value: Qt.vector3d(-6.59355e-15, 180, 20)
//            }
//            Keyframe {
//                frame: 700
//                value: Qt.vector3d(3.50835e-15, 180, 120)
//            }
//            Keyframe {
//                frame: 733.333
//                value: Qt.vector3d(5.37511e-15, -180, -140)
//            }
//            Keyframe {
//                frame: 766.667
//                value: Qt.vector3d(-5.37511e-15, -180, -40)
//            }
//            Keyframe {
//                frame: 800
//                value: Qt.vector3d(-3.50835e-15, 180, 60)
//            }
//            Keyframe {
//                frame: 833.333
//                value: Qt.vector3d(6.59355e-15, 180, 160)
//            }
//            Keyframe {
//                frame: 866.667
//                value: Qt.vector3d(1.21844e-15, -180, -100)
//            }
//            Keyframe {
//                frame: 900
//                value: Qt.vector3d(-7.01671e-15, 180, 1.08794e-13)
//            }
//            Keyframe {
//                frame: 933.333
//                value: Qt.vector3d(1.21844e-15, 180, 100)
//            }
//            Keyframe {
//                frame: 966.667
//                value: Qt.vector3d(6.59355e-15, -180, -160)
//            }
//            Keyframe {
//                frame: 1000
//                value: Qt.vector3d(-3.50835e-15, -180, -60)
//            }
//            Keyframe {
//                frame: 1033.33
//                value: Qt.vector3d(-5.37511e-15, 180, 40)
//            }
//            Keyframe {
//                frame: 1066.67
//                value: Qt.vector3d(5.37511e-15, 180, 140)
//            }
//            Keyframe {
//                frame: 1100
//                value: Qt.vector3d(3.50835e-15, -180, -120)
//            }
//            Keyframe {
//                frame: 1133.33
//                value: Qt.vector3d(-6.59355e-15, -180, -20)
//            }
//            Keyframe {
//                frame: 1166.67
//                value: Qt.vector3d(-1.21844e-15, 180, 80)
//            }
//            Keyframe {
//                frame: 1200
//                value: Qt.vector3d(7.01671e-15, 180, 180)
//            }
//            Keyframe {
//                frame: 1233.33
//                value: Qt.vector3d(-1.21844e-15, -180, -80)
//            }
//            Keyframe {
//                frame: 1266.67
//                value: Qt.vector3d(-6.59355e-15, 180, 20)
//            }
//            Keyframe {
//                frame: 1300
//                value: Qt.vector3d(3.50833e-15, 180, 120)
//            }
//            Keyframe {
//                frame: 1333.33
//                value: Qt.vector3d(5.37511e-15, -180, -140)
//            }
//            Keyframe {
//                frame: 1366.67
//                value: Qt.vector3d(-5.37511e-15, -180, -40)
//            }
//            Keyframe {
//                frame: 1400
//                value: Qt.vector3d(-3.50835e-15, 180, 60)
//            }
//            Keyframe {
//                frame: 1433.33
//                value: Qt.vector3d(6.59355e-15, 180, 160)
//            }
//            Keyframe {
//                frame: 1466.67
//                value: Qt.vector3d(1.21844e-15, -180, -100)
//            }
//            Keyframe {
//                frame: 1500
//                value: Qt.vector3d(-7.01671e-15, 180, 3.24611e-14)
//            }
//            Keyframe {
//                frame: 1533.33
//                value: Qt.vector3d(1.21844e-15, 180, 100)
//            }
//            Keyframe {
//                frame: 1566.67
//                value: Qt.vector3d(6.59355e-15, -180, -160)
//            }
//            Keyframe {
//                frame: 1600
//                value: Qt.vector3d(-3.50835e-15, -180, -60)
//            }
//            Keyframe {
//                frame: 1633.33
//                value: Qt.vector3d(-5.37511e-15, 180, 40)
//            }
//            Keyframe {
//                frame: 1666.67
//                value: Qt.vector3d(5.37511e-15, 180, 140)
//            }
//            Keyframe {
//                frame: 1700
//                value: Qt.vector3d(3.50835e-15, -180, -120)
//            }
//            Keyframe {
//                frame: 1733.33
//                value: Qt.vector3d(-6.59355e-15, -180, -20)
//            }
//            Keyframe {
//                frame: 1766.67
//                value: Qt.vector3d(-1.21844e-15, 180, 80)
//            }
//            Keyframe {
//                frame: 1800
//                value: Qt.vector3d(7.01671e-15, -180, -180)
//            }
//            Keyframe {
//                frame: 1833.33
//                value: Qt.vector3d(-1.21844e-15, -180, -80)
//            }
//            Keyframe {
//                frame: 1866.67
//                value: Qt.vector3d(-6.59355e-15, 180, 20)
//            }
//            Keyframe {
//                frame: 1900
//                value: Qt.vector3d(3.50835e-15, 180, 120)
//            }
//            Keyframe {
//                frame: 1933.33
//                value: Qt.vector3d(5.37511e-15, -180, -140)
//            }
//            Keyframe {
//                frame: 1966.67
//                value: Qt.vector3d(-5.37511e-15, -180, -40)
//            }
//            Keyframe {
//                frame: 2000
//                value: Qt.vector3d(-3.50835e-15, 180, 60)
//            }
//            Keyframe {
//                frame: 2033.33
//                value: Qt.vector3d(6.59355e-15, 180, 160)
//            }
//            Keyframe {
//                frame: 2066.67
//                value: Qt.vector3d(1.21844e-15, -180, -100)
//            }
//            Keyframe {
//                frame: 2100
//                value: Qt.vector3d(-7.01671e-15, -180, -0.000488281)
//            }
//            Keyframe {
//                frame: 2133.33
//                value: Qt.vector3d(1.21844e-15, 180, 100)
//            }
//            Keyframe {
//                frame: 2166.67
//                value: Qt.vector3d(6.59355e-15, -180, -160)
//            }
//            Keyframe {
//                frame: 2200
//                value: Qt.vector3d(-3.50835e-15, -180, -60)
//            }
//            Keyframe {
//                frame: 2233.33
//                value: Qt.vector3d(-5.37511e-15, 180, 40)
//            }
//            Keyframe {
//                frame: 2266.67
//                value: Qt.vector3d(5.37511e-15, 180, 140)
//            }
//            Keyframe {
//                frame: 2300
//                value: Qt.vector3d(3.50835e-15, -180, -120)
//            }
//            Keyframe {
//                frame: 2333.33
//                value: Qt.vector3d(-6.59355e-15, -180, -20)
//            }
//            Keyframe {
//                frame: 2366.67
//                value: Qt.vector3d(-1.2185e-15, 180, 79.9995)
//            }
//            Keyframe {
//                frame: 2400
//                value: Qt.vector3d(7.01671e-15, 180, 180)
//            }
//            Keyframe {
//                frame: 2433.33
//                value: Qt.vector3d(-1.21844e-15, -180, -80)
//            }
//            Keyframe {
//                frame: 2466.67
//                value: Qt.vector3d(-6.59355e-15, 180, 20)
//            }
//            Keyframe {
//                frame: 2500
//                value: Qt.vector3d(3.50835e-15, 180, 120)
//            }
//            Keyframe {
//                frame: 2533.33
//                value: Qt.vector3d(5.37511e-15, -180, -140)
//            }
//            Keyframe {
//                frame: 2566.67
//                value: Qt.vector3d(-5.37511e-15, -180, -40)
//            }
//            Keyframe {
//                frame: 2600
//                value: Qt.vector3d(-3.50841e-15, 180, 59.9995)
//            }
//            Keyframe {
//                frame: 2633.33
//                value: Qt.vector3d(6.59355e-15, 180, 160)
//            }
//            Keyframe {
//                frame: 2666.67
//                value: Qt.vector3d(1.21844e-15, -180, -100)
//            }
//            Keyframe {
//                frame: 2700
//                value: Qt.vector3d(-7.01671e-15, -180, -1.08794e-13)
//            }
//            Keyframe {
//                frame: 2733.33
//                value: Qt.vector3d(1.21844e-15, 180, 100)
//            }
//            Keyframe {
//                frame: 2766.67
//                value: Qt.vector3d(6.59355e-15, -180, -160)
//            }
//            Keyframe {
//                frame: 2800
//                value: Qt.vector3d(-3.50835e-15, -180, -60)
//            }
//            Keyframe {
//                frame: 2833.33
//                value: Qt.vector3d(-5.37511e-15, 180, 40)
//            }
//            Keyframe {
//                frame: 2866.67
//                value: Qt.vector3d(5.37511e-15, 180, 140)
//            }
//            Keyframe {
//                frame: 2900
//                value: Qt.vector3d(3.50835e-15, -180, -120)
//            }
//            Keyframe {
//                frame: 2933.33
//                value: Qt.vector3d(-6.59355e-15, -180, -20)
//            }
//            Keyframe {
//                frame: 2966.67
//                value: Qt.vector3d(-1.21844e-15, 180, 80)
//            }
//            Keyframe {
//                frame: 3000
//                value: Qt.vector3d(7.01671e-15, -180, -180)
//            }
//        }

//        KeyframeGroup {
//            target: null_
//            property: "scale"

//            Keyframe {
//                frame: 0
//                value: Qt.vector3d(1, 1, 1)
//            }
//        }
//    }

}
