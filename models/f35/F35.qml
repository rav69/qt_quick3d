import QtQuick 2.15
import QtQuick3D 1.15

Node {
    id: sketchfab_model
    eulerRotation.x: -90

    Node {
        id: f_35_fbx
        eulerRotation.x: 90
        scale.x: 0.01
        scale.y: 0.01
        scale.z: 0.01

        Node {
            id: rootNode

            Node {
                id: f_35_airframe
                y: 2630.97
                eulerRotation.x: -4.32571e-06
                scale.x: 100
                scale.y: 100
                scale.z: 100

                Model {
                    id: f_35_airframe_F_35_airframe_0
                    source: "meshes/f_35_airframe_F_35_airframe_0.mesh"

                    PrincipledMaterial {
                        id: f_35_airframe_material
                        baseColorMap: Texture {
                            source: "maps/0.png"
                            tilingModeHorizontal: Texture.Repeat
                            tilingModeVertical: Texture.Repeat
                        }
                        opacityChannel: Material.A
                        metalness: 0
                        roughness: 0.821115
                        normalMap: Texture {
                            source: "maps/1.png"
                            tilingModeHorizontal: Texture.Repeat
                            tilingModeVertical: Texture.Repeat
                        }
                        cullMode: Material.NoCulling
                    }
                    materials: [
                        f_35_airframe_material
                    ]
                }
            }

            Node {
                id: f_35_canopy
                y: 2630.97
                eulerRotation.x: -4.32571e-06
                scale.x: 100
                scale.y: 100
                scale.z: 100

                Model {
                    id: f_35_canopy_glass_0
                    source: "meshes/f_35_canopy_glass_0.mesh"

                    PrincipledMaterial {
                        id: glass_material
                        baseColor: "#ff000000"
                        metalness: 0
                        roughness: 1
                        cullMode: Material.NoCulling
                    }
                    materials: [
                        glass_material
                    ]
                }
            }

            Node {
                id: f_35_cockpit
                y: 2630.97
                eulerRotation.x: -4.32571e-06
                scale.x: 100
                scale.y: 100
                scale.z: 100

                Model {
                    id: f_35_cockpit_F_35_airframe_0
                    source: "meshes/f_35_cockpit_F_35_airframe_0.mesh"
                    materials: [
                        f_35_airframe_material
                    ]
                }
            }

            Node {
                id: f_35_instrGlass_nav
                y: 2630.97
                eulerRotation.x: -4.32571e-06
                scale.x: 100
                scale.y: 100
                scale.z: 100

                Model {
                    id: f_35_instrGlass_nav_inst_glass_0
                    source: "meshes/f_35_instrGlass_nav_inst_glass_0.mesh"

                    PrincipledMaterial {
                        id: inst_glass_material
                        baseColor: "#ffcccccc"
                        metalness: 0
                        roughness: 0.804041
                        cullMode: Material.NoCulling
                    }
                    materials: [
                        inst_glass_material
                    ]
                }
            }

            Node {
                id: f_35_instrGlass_sensor
                y: 2630.97
                eulerRotation.x: -4.32571e-06
                scale.x: 100
                scale.y: 100
                scale.z: 100

                Model {
                    id: f_35_instrGlass_sensor_inst_glass_0
                    source: "meshes/f_35_instrGlass_sensor_inst_glass_0.mesh"
                    materials: [
                        inst_glass_material
                    ]
                }
            }

            Node {
                id: f_35_landingOff
                y: 2630.97
                eulerRotation.x: -4.32571e-06
                scale.x: 100
                scale.y: 100
                scale.z: 100

                Model {
                    id: f_35_landingOff_F_35_airframe_0
                    source: "meshes/f_35_landingOff_F_35_airframe_0.mesh"
                    materials: [
                        f_35_airframe_material
                    ]
                }
            }

            Node {
                id: f_35_landingOn
                y: 2630.97
                eulerRotation.x: -4.32571e-06
                scale.x: 100
                scale.y: 100
                scale.z: 100

                Model {
                    id: f_35_landingOn_F_35_airframe_0
                    source: "meshes/f_35_landingOn_F_35_airframe_0.mesh"
                    materials: [
                        f_35_airframe_material
                    ]
                }
            }

            Node {
                id: f_35_landingOnLight
                y: 2630.97
                eulerRotation.x: -4.32571e-06
                scale.x: 100
                scale.y: 100
                scale.z: 100

                Model {
                    id: f_35_landingOnLight_F_35_landingLights_0
                    source: "meshes/f_35_landingOnLight_F_35_landingLights_0.mesh"

                    PrincipledMaterial {
                        id: f_35_landingLights_material
                        metalness: 0
                        roughness: 0.683772
                        emissiveColor: "#ffffffff"
                        cullMode: Material.NoCulling
                    }
                    materials: [
                        f_35_landingLights_material
                    ]
                }
            }
        }
    }
}
