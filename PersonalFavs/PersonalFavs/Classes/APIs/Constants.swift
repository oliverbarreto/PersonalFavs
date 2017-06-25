//
//  Constants.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 24/5/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

struct Config {
    
    struct CellIDs {
        
        static let homeVCCellID = "homeVCGroupCellID"       // Home - UICollectionViewController Cells
        
        
        static let favsCellID = "favsCellID"                // Favs - UICollectionViewController
        
    }
    

    struct HomeController {
        struct DateHeaderContainerView {
            static let initialContentOffset = 280.0             // Starting position of collectionview down the screen

            static let dateheaderContainerViewTopMargin = 70.0  // Distance of container view to the top of the screen for its use to setup topanchor constraint
            static let dateheaderContainerViewHeight = 90       // Container view Height to acommodate the tiem and date labels
            
            static let timeLabelHight = 70.0                    // Height of time label
            static let dateLabelHight = 20.0                    // Height of date label
        }
    }
    

    // GROUPCOLLECTIONVC  - TO BE REMOVED
    struct DataSource {
        static let numberOfSectionsInCollectionHomeView = 1
        static let numberOfItemsInCollectionHomeView = 17
    }
    
    
    struct CollectionViewLayout {
        
        struct HomeVC {
            // Numer of items per row and spacing
            static let itemsPerRow = 2
            //static let itemsPadding = itemsMinimumInteritemSpacing
            
            // Minimum FlowLayout spacing/padding for line and items
            static let itemsMinimumInteritemSpacing = 5.0
            static let itemsMinimumLineSpacing = 12.0
            
            // UIEdgeInsets
            static let groupCardPaddingLeft = 10.0
            static let groupCardPaddingRight = 10.0
            static let groupCardPaddingTop = 15.0
            static let groupCardPaddingBottom = 15.0
            
            // Section Header 
            static let groupCardHeaderHeightSize = 44.0
        }
        
        struct FavsVC {
            // Numer of items per row and spacing
            static let itemsPerRow = 4
            //static let itemsPadding = itemsMinimumInteritemSpacing
            
            // Minimum FlowLayout spacing/padding for line and items
            static let itemsMinimumInteritemSpacing = 8.0
            static let itemsMinimumLineSpacing = 20.0
            
            // UIEdgeInsets
            static let sectionPaddingLeft = 5.0
            static let sectionPaddingRight = 5.0
            static let sectionPaddingTop = 410.0
            static let sectionPaddingBottom = 5.0
            
            // BackgroundShadeView
            static let backgroundShadeView = 460.0
            
        }
        
        
    }
    
    struct PersonalFavCell {
        static let labelWidth = 10
        static let typelabelHeight = 12
        static let namelabelHeight = 16
        
        static let thumbnailImageViewCornerRadius = 50
    }
    
    
    struct Colors {
        
        struct FlatColors {
            // Green
            static let turqoise = "#1abc9c"
            static let greenSea = "#16a085"
            static let emerald = "#2ecc71"
            static let nephritis = "#27ae60"
            
            //Blue
            static let peterRiver = "#3498db"
            static let bezielhole = "#2980b9"
            static let wetAsphalt = "#34495e"
            static let midnightBlue = "#2c3e50"
            
            // Violet
            static let amethyst = "#9b59b6"
            static let wisteria = "#8e44ad"
            
            // Yellow & Orange
            static let sunFlower = "#f1c40f"
            static let orange = "#f39c12"
            static let carrot = "#e67e22"
            static let pumkin = "#d35400"
            
            //Red
            static let alizarin = "#e74c3c"
            static let pomegranate = "#c0392b"
            
            // White & Greys
            static let clouds = "#ecf0f1"
            static let silver = "#bdc3c7"
            static let concrete = "#95a5a6"
            static let asbestos = "#7f8c8d"
            static let porcelain = "#ECF0F1" //236, 240, 241
            
            //more colors here http://www.flatuicolorpicker.com
            
        }
        
        struct MaterialColors {
            /*
             SOFT RED
             EC644B
             236,100,75
             
             CHESTNUT ROSE
             D24D57
             210, 77, 87
             
             POMEGRANATE
             F22613
             242, 38, 19
             
             THUNDERBIRD
             D91E18
             217, 30, 24
             
             OLD BRICK
             96281B
             150, 40, 27
             
             FLAMINGO
             EF4836
             239, 72, 54
             
             VALENCIA
             D64541
             214, 69, 65
             
             TALL POPPY
             C0392B
             192, 57, 43
             
             MONZA
             CF000F
             207, 0, 15
             
             CINNABAR
             E74C3C
             231, 76, 60
             
             RAZZMATAZZ
             DB0A5B
             219, 10, 91
             
             SUNSET ORANGE
             F64747
             246, 71, 71
             
             WAX FLOWER
             F1A9A0
             241, 169, 160
             
             CABARET
             D2527F
             210, 82, 127
             
             NEW YORK PINK
             E08283
             224, 130, 131
             
             RADICAL RED
             F62459
             246, 36, 89
             
             SUNGLO
             E26A6A
             226, 106, 106
             
             SNUFF
             DCC6E0
             220, 198, 224
             
             REBECCAPURPLE
             663399
             102, 51, 153
             
             HONEY FLOWER
             674172
             103, 65, 114
             
             WISTFUL
             AEA8D3
             174, 168, 211
             
             PLUM
             913D88
             145, 61, 136
             
             SEANCE
             9A12B3
             154, 18, 179
             
             MEDIUM PURPLE
             BF55EC
             191, 85, 236
             
             LIGHT WISTERIA
             BE90D4
             190, 144, 212
             
             STUDIO
             8E44AD
             142, 68, 173
             
             WISTERIA
             9B59B6
             155, 89, 182
             
             SAN MARINO
             446CB3
             68,108,179
             
             ALICE BLUE
             E4F1FE
             228, 241, 254
             
             ROYAL BLUE
             4183D7
             65, 131, 215
             
             PICTON BLUE
             59ABE3
             89, 171, 227
             
             SPRAY
             81CFE0
             129, 207, 224
             
             SHAKESPEARE
             52B3D9
             82, 179, 217
             
             HUMMING BIRD
             C5EFF7
             197, 239, 247
             
             PICTON BLUE
             22A7F0
             34, 167, 240
             
             CURIOUS BLUE
             3498DB
             52, 152, 219
             
             MADISON
             2C3E50
             44, 62, 80
             
             DODGER BLUE
             19B5FE
             25, 181, 254
             
             MING
             336E7B
             51, 110, 123
             
             EBONY CLAY
             22313F
             34, 49, 63
             
             MALIBU
             6BB9F0
             107, 185, 240
             
             SUMMER SKY
             1E8BC3
             30, 139, 195
             
             CHAMBRAY
             3A539B
             58, 83, 155
             
             PICKLED BLUEWOOD
             34495E
             52, 73, 94
             
             HOKI
             67809F
             103, 128, 159
             
             JELLY BEAN
             2574A9
             37, 116, 169
             
             JACKSONS PURPLE
             1F3A93
             31, 58, 147
             
             JORDY BLUE
             89C4F4
             137, 196, 244
             
             STEEL BLUE
             4B77BE
             75, 119, 190
             
             FOUNTAIN BLUE
             5C97BF
             92, 151, 191
             
             MEDIUM TURQUOISE
             4ECDC4
             78,205,196
             
             AQUA ISLAND
             A2DED0
             162, 222, 208
             
             GOSSIP
             87D37C
             135, 211, 124
             
             DARK SEA GREEN
             90C695
             144, 198, 149
             
             EUCALYPTUS
             26A65B
             38, 166, 91
             
             CARIBBEAN GREEN
             03C9A9
             3, 201, 169
             
             SILVER TREE
             68C3A3
             104, 195, 163
             
             DOWNY
             65C6BB
             101, 198, 187
             
             MOUNTAIN MEADOW
             1BBC9B
             27, 188, 155
             
             LIGHT SEA GREEN
             1BA39C
             27, 163, 156
             
             MEDIUM AQUAMARINE
             66CC99
             102, 204, 153
             
             TURQUOISE
             36D7B7
             54, 215, 183
             
             MADANG
             C8F7C5
             200, 247, 197
             
             RIPTIDE
             86E2D5
             134, 226, 213
             
             SHAMROCK
             2ECC71
             46, 204, 113
             
             NIAGARA
             16A085
             22, 160, 133
             
             EMERALD
             3FC380
             63, 195, 128
             
             GREEN HAZE
             019875
             1, 152, 117
             
             FREE SPEECH AQUAMARINE
             03A678
             3, 166, 120
             
             OCEAN GREEN
             4DAF7C
             77, 175, 124
             
             NIAGARA 1
             2ABB9B
             42, 187, 155
             
             JADE
             00B16A
             0, 177, 106
             
             SALEM
             1E824C
             30, 130, 76
             
             OBSERVATORY
             049372
             4, 147, 114
             
             JUNGLE GREEN
             26C281
             38, 194, 129
             
             CREAM CAN
             F5D76E
             245, 215, 110
             
             RIPE LEMON
             F7CA18
             247, 202, 24
             
             SAFFRON
             F4D03F
             244, 208, 63
             
             CONFETTI
             #E9D460
             (233,212,96)
             
             CAPE HONEY
             FDE3A7
             253, 227, 167
             
             CALIFORNIA
             F89406
             248, 148, 6
             
             FIRE BUSH
             EB9532
             235, 149, 50
             
             TAHITI GOLD
             E87E04
             232, 126, 4
             
             CASABLANCA
             F4B350
             244, 179, 80
             
             CRUSTA
             F2784B
             242, 120, 75
             
             SEA BUCKTHORN
             EB974E
             235, 151, 78
             
             LIGHTNING YELLOW
             F5AB35
             245, 171, 53
             
             BURNT ORANGE
             D35400
             211, 84, 0
             
             BUTTERCUP
             F39C12
             243, 156, 18
             
             ECSTASY
             F9690E
             249, 105, 14
             
             SANDSTORM
             F9BF3B
             249, 191, 59
             
             JAFFA
             F27935
             242, 121, 53
             
             ZEST
             E67E22
             230, 126, 34
             
             WHITE SMOKE
             ECECEC
             236,236,236
             
             LYNCH
             6C7A89
             108, 122, 137
             
             PUMICE
             D2D7D3
             210, 215, 211
             
             GALLERY
             EEEEEE
             238, 238, 238
             
             SILVER SAND
             BDC3C7
             189, 195, 199
             
             PORCELAIN
             ECF0F1
             236, 240, 241
             
             CASCADE
             95A5A6
             149, 165, 166
             
             IRON
             DADFE1
             218, 223, 225
             
             EDWARD
             ABB7B7
             171, 183, 183
             
             CARARRA
             F2F1EF
             242, 241, 239
             
             SILVER
             BFBFBF
             191, 191, 191
            */
        }
        
        struct CustomPalette {
            
            static let SteelBlue = "#2E86AB"           // Steel Blue
            static let Vanilla = "#F6F5AE"             // Vanilla
            static let Vermilion = "#F24236"           // Vermilion
            static let LemonYellow = "#F5F749"         // Lemon Yellow
            static let DarkLiverHorses = "#564138"     // Dark Liver Horses
            
            static let primaryBGColor = "#2E86AB"
            static let secondaryBGColor = "#F24236"
            static let primaryTextColor = "#ffffff"
            static let secondaryTextColor = "#F6F5AE"
        }
    }
    
}
