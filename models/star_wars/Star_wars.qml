import QtQuick 2.15
import QtQuick3D 1.15

Node {
    id: sketchfab_model
    eulerRotation.x: -90

    Node {
        id: halcon_Milenario_obj_cleaner

        Model {
            id: object_2
            source: "meshes/object_2.mesh"

            PrincipledMaterial {
                id: cP_Front_material
                baseColorMap: Texture {
                    source: "maps/0.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                cP_Front_material
            ]
        }

        Model {
            id: object_3
            source: "meshes/object_3.mesh"

            PrincipledMaterial {
                id: cockpit2_material
                baseColorMap: Texture {
                    source: "maps/1.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                cockpit2_material
            ]
        }

        Model {
            id: object_4
            source: "meshes/object_4.mesh"

            PrincipledMaterial {
                id: cockpit3_material
                baseColorMap: Texture {
                    source: "maps/2.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                cockpit3_material
            ]
        }

        Model {
            id: object_5
            source: "meshes/object_5.mesh"

            PrincipledMaterial {
                id: dish01_material
                baseColorMap: Texture {
                    source: "maps/3.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                dish01_material
            ]
        }

        Model {
            id: object_6
            source: "meshes/object_6.mesh"

            PrincipledMaterial {
                id: dish02_material
                baseColorMap: Texture {
                    source: "maps/4.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                dish02_material
            ]
        }

        Model {
            id: object_7
            source: "meshes/object_7.mesh"

            PrincipledMaterial {
                id: drivBack_material
                baseColorMap: Texture {
                    source: "maps/5.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                drivBack_material
            ]
        }

        Model {
            id: object_8
            source: "meshes/object_8.mesh"

            PrincipledMaterial {
                id: engine01_material
                baseColorMap: Texture {
                    source: "maps/6.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                engine01_material
            ]
        }

        Model {
            id: object_9
            source: "meshes/object_9.mesh"

            PrincipledMaterial {
                id: engine02_material
                baseColor: "#ccffffff"
                baseColorMap: Texture {
                    source: "maps/7.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
                alphaMode: PrincipledMaterial.Blend
            }
            materials: [
                engine02_material
            ]
        }

        Model {
            id: object_10
            source: "meshes/object_10.mesh"

            PrincipledMaterial {
                id: m_Inside_material
                baseColorMap: Texture {
                    source: "maps/8.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                m_Inside_material
            ]
        }

        Model {
            id: object_11
            source: "meshes/object_11.mesh"

            PrincipledMaterial {
                id: mandbEnd_material
                baseColorMap: Texture {
                    source: "maps/9.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                mandbEnd_material
            ]
        }

        Model {
            id: object_12
            source: "meshes/object_12.mesh"

            PrincipledMaterial {
                id: podSide1_material
                baseColorMap: Texture {
                    source: "maps/10.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                podSide1_material
            ]
        }

        Model {
            id: object_13
            source: "meshes/object_13.mesh"

            PrincipledMaterial {
                id: sidePort_material
                baseColorMap: Texture {
                    source: "maps/11.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                sidePort_material
            ]
        }

        Model {
            id: object_14
            source: "meshes/object_14.mesh"

            PrincipledMaterial {
                id: sideRear_material
                baseColorMap: Texture {
                    source: "maps/12.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                sideRear_material
            ]
        }

        Model {
            id: object_15
            source: "meshes/object_15.mesh"

            PrincipledMaterial {
                id: sideRear1_material
                baseColorMap: Texture {
                    source: "maps/13.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                sideRear1_material
            ]
        }

        Model {
            id: object_16
            source: "meshes/object_16.mesh"

            PrincipledMaterial {
                id: turret_L_material
                baseColorMap: Texture {
                    source: "maps/14.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                turret_L_material
            ]
        }

        Model {
            id: object_17
            source: "meshes/object_17.mesh"

            PrincipledMaterial {
                id: dishSide_material
                baseColorMap: Texture {
                    source: "maps/15.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                dishSide_material
            ]
        }

        Model {
            id: object_18
            source: "meshes/object_18.mesh"

            PrincipledMaterial {
                id: escPod_L_material
                baseColorMap: Texture {
                    source: "maps/16.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                escPod_L_material
            ]
        }

        Model {
            id: object_19
            source: "meshes/object_19.mesh"

            PrincipledMaterial {
                id: escPod_U_material
                baseColorMap: Texture {
                    source: "maps/17.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                escPod_U_material
            ]
        }

        Model {
            id: object_20
            source: "meshes/object_20.mesh"

            PrincipledMaterial {
                id: falcPlan_material
                baseColorMap: Texture {
                    source: "maps/18.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                falcPlan_material
            ]
        }

        Model {
            id: object_21
            source: "meshes/object_21.mesh"

            PrincipledMaterial {
                id: falcUndr_material
                baseColorMap: Texture {
                    source: "maps/19.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                falcUndr_material
            ]
        }

        Model {
            id: object_22
            source: "meshes/object_22.mesh"
            materials: [
                falcUndr_material
            ]
        }

        Model {
            id: object_23
            source: "meshes/object_23.mesh"

            PrincipledMaterial {
                id: frontColor_material
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                frontColor_material
            ]
        }

        Model {
            id: object_24
            source: "meshes/object_24.mesh"

            PrincipledMaterial {
                id: hatch_material
                baseColorMap: Texture {
                    source: "maps/20.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                hatch_material
            ]
        }

        Model {
            id: object_25
            source: "meshes/object_25.mesh"

            PrincipledMaterial {
                id: turret_U_material
                baseColorMap: Texture {
                    source: "maps/21.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                turret_U_material
            ]
        }

        Model {
            id: object_26
            source: "meshes/object_26.mesh"

            PrincipledMaterial {
                id: vent01_material
                baseColorMap: Texture {
                    source: "maps/22.png"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                }
                opacityChannel: Material.A
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                vent01_material
            ]
        }

        Model {
            id: object_27
            source: "meshes/object_27.mesh"

            PrincipledMaterial {
                id: charcoal_1_material
                baseColor: "#ff232323"
                metalness: 0
                roughness: 0.6
                cullMode: Material.NoCulling
            }
            materials: [
                charcoal_1_material
            ]
        }
    }
}
