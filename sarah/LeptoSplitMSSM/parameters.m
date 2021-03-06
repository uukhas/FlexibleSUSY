(* ::Package:: *)

(* :Copyright:

   ====================================================================
   This file is part of FlexibleSUSY.

   FlexibleSUSY is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published
   by the Free Software Foundation, either version 3 of the License,
   or (at your option) any later version.

   FlexibleSUSY is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with FlexibleSUSY.  If not, see
   <http://www.gnu.org/licenses/>.
   ====================================================================

*)

ParameterDefinitions = {
    {g1,        { Description -> "Hypercharge-Coupling"}},
    {g2,        { Description -> "Left-Coupling"}},
    {g3,        { Description -> "Strong-Coupling"}},
    {AlphaS,    { Description -> "Alpha Strong"}},
    {e,         { Description -> "electric charge"}},
    {Gf,        { Description -> "Fermi's constant"}},
    {aEWinv,    { Description -> "inverse weak coupling constant at mZ"}},
    {Yu,        { Description -> "Up-Yukawa-Coupling",
                  DependenceNum ->  Sqrt[2]/v* {{Mass[Fu,1],0,0},
                                                {0, Mass[Fu,2],0},
                                                {0, 0, Mass[Fu,3]}}}},
    {Yd,        { Description -> "Down-Yukawa-Coupling",
                  DependenceNum ->  Sqrt[2]/v* {{Mass[Fd,1],0,0},
                                                {0, Mass[Fd,2],0},
                                                {0, 0, Mass[Fd,3]}}}},
    {Ye,        { Description -> "Lepton-Yukawa-Coupling",
                  DependenceNum ->  Sqrt[2]/v* {{Mass[Fe,1],0,0},
                                                {0, Mass[Fe,2],0},
                                                {0, 0, Mass[Fe,3]}}}},
    {mu2,       { Description -> "SM Mu Parameter",
                  LaTeX -> "m^2",
                  OutputName -> mu2 }},
    {\[Lambda], { Description -> "SM Higgs Selfcouplings",
                  DependenceNum -> Mass[hh]^2/(2 v^2)}},
    {v,         { Description -> "EW-VEV",
                  DependenceNum -> Sqrt[4*Mass[VWp]^2/(g2^2)],
                  DependenceSPheno -> None  }},
    {ThetaW,    { Description -> "Weinberg-Angle",
                  DependenceNum -> ArcSin[Sqrt[1 - Mass[VWp]^2/Mass[VZ]^2]]  }},
    {ZZ,        { Description -> "Photon-Z Mixing Matrix"}},
    {ZW,        { Description -> "W Mixing Matrix",
                  Dependence ->   1/Sqrt[2] {{1, 1},
                                             {I,-I}} }},
    {Vu,        { Description ->"Left-Up-Mixing-Matrix"}},
    {Vd,        { Description ->"Left-Down-Mixing-Matrix"}},
    {Uu,        { Description ->"Right-Up-Mixing-Matrix"}},
    {Ud,        { Description ->"Right-Down-Mixing-Matrix"}},
    {Ve,        { Description ->"Left-Lepton-Mixing-Matrix"}},
    {Ue,        { Description ->"Right-Lepton-Mixing-Matrix"}},

(* split MSSM parameters *)

    {ZN,        { Description -> "Neutralino Mixing-Matrix" }},
    {UP,        { Description -> "Chargino-plus Mixing-Matrix" }},
    {UM,        { Description -> "Chargino-minus Mixing-Matrix" }},
    {ZE,        { Description -> "Slepton-Mixing-Matrix" }},
    {ZV,        { Description -> "Sneutrino Mixing-Matrix" }},
    {MassB,     { Description -> "Bino Mass parameter",
                  Real -> True }},
    {MassWB,    { Description -> "Wino Mass parameter",
                  Real -> True }},
    {\[Mu],     { Description -> "Mu-parameter",
                  Real -> True,
                  LaTeX -> "\\mu_{\\text{MSSM}}",
                  OutputName -> Mu }},
    {g1u,       { Description -> "Higgs-Bino-Up-Higgsino-Coupling",
                  Real -> True,
                  OutputName -> g1u,
                  LaTeX -> "\\tilde{g}_{1\\text{u}}",
                  LesHouches -> {SplitMSSM,1} }},
    {g2u,       { Description -> "Higgs-Wino-Up-Higgsino-Coupling",
                  Real -> True,
                  OutputName -> g2u,
                  LaTeX -> "\\tilde{g}_{2\\text{u}}",
                  LesHouches -> {SplitMSSM,2} }},
    {g1d,       { Description -> "Higgs-Bino-Down-Higgsino-Coupling",
                  Real -> True,
                  OutputName -> g1d,
                  LaTeX -> "\\tilde{g}_{1\\text{d}}",
                  LesHouches -> {SplitMSSM,3} }},
    {g2d,       { Description -> "Higgs-Wino-Down-Higgsino-Coupling",
                  Real -> True,
                  OutputName -> g2d,
                  LaTeX -> "\\tilde{g}_{2\\text{d}}",
                  LesHouches -> {SplitMSSM,4} }},

    {ml11,      { Description -> "Softbreaking left 1-1 generation Slepton Mass",
                  OutputName -> ml11}},
    {ml12,      { Description -> "Softbreaking left 1-2 generation Slepton Mass",
                  OutputName -> ml12 }},
    {ml21,      { Description -> "Softbreaking left 2-1 generation Slepton Mass",
                  OutputName -> ml21 }},
    {ml22,      { Description -> "Softbreaking left 2-2 generation Slepton Mass",
                  OutputName -> ml22 }},

    {me11,      { Description -> "Softbreaking right 1-1 generation Slepton Mass",
                  OutputName -> me11 }},
    {me12,      { Description -> "Softbreaking right 1-2 generation Slepton Mass",
                  OutputName -> me12 }},
    {me21,      { Description -> "Softbreaking right 2-1 generation Slepton Mass",
                  OutputName -> me21 }},
    {me22,      { Description -> "Softbreaking right 2-2 generation Slepton Mass",
                  OutputName -> me22 }},


    {glllla11,  { Description -> "Quartic-Left-1-1-Slepton-Coupling",
                  Real -> True,
                  OutputName -> glllla11,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{l}\\tilde{l}\\tilde{l}a,11}",
                  LesHouches -> {SplitMSSM,5} }},
    {glllla12,  { Description -> "Quartic-Left-1-2-Slepton-Coupling",
                  Real -> True,
                  OutputName -> glllla12,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{l}\\tilde{l}\\tilde{l}a,12}",
                  LesHouches -> {SplitMSSM,5} }},
    {glllla22,  { Description -> "Quartic-Left-2-2-Slepton-Coupling",
                  Real -> True,
                  OutputName -> glllla22,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{l}\\tilde{l}\\tilde{l}a,22}",
                  LesHouches -> {SplitMSSM,5} }},
    {gllllb,    { Description -> "Quartic-Left-Mixing-Slepton-Coupling",
                  Real -> True,
                  OutputName -> gllllb,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{l}\\tilde{l}\\tilde{l}b}",
                  LesHouches -> {SplitMSSM,5} }},

    {gllhha11,  { Description -> "Quartic-Higgs-Left-a-1-1-Slepton-Coupling",
                  Real -> True,
                  OutputName -> gllhha11,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{l}\\tilde{h}\\tilde{h}a,11}",
                  LesHouches -> {SplitMSSM,6} }},
    {gllhha12,  { Description -> "Quartic-Higgs-Left-a-1-2-Slepton-Coupling",
                  Real -> True,
                  OutputName -> gllhha12,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{l}\\tilde{h}\\tilde{h}a,12}",
                  LesHouches -> {SplitMSSM,6} }},
    {gllhha21,  { Description -> "Quartic-Higgs-Left-a-2-1-Slepton-Coupling",
                  Real -> True,
                  OutputName -> gllhha21,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{l}\\tilde{h}\\tilde{h}a,21}",
                  LesHouches -> {SplitMSSM,6} }},
    {gllhha22,  { Description -> "Quartic-Higgs-Left-a-2-2-Slepton-Coupling",
                  Real -> True,
                  OutputName -> gllhha22,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{l}\\tilde{h}\\tilde{h}a,22}",
                  LesHouches -> {SplitMSSM,6} }},
    {gllhhb11,  { Description -> "Quartic-Higgs-Left-b-1-1-Slepton-Coupling",
                  Real -> True,
                  OutputName -> gllhhb11,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{l}\\tilde{h}\\tilde{h}b,11}",
                  LesHouches -> {SplitMSSM,7} }},
    {gllhhb12,  { Description -> "Quartic-Higgs-Left-b-1-2-Slepton-Coupling",
                  Real -> True,
                  OutputName -> gllhhb12,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{l}\\tilde{h}\\tilde{h}b,12}",
                  LesHouches -> {SplitMSSM,7} }},
    {gllhhb21,  { Description -> "Quartic-Higgs-Left-b-2-1-Slepton-Coupling",
                  Real -> True,
                  OutputName -> gllhhb21,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{l}\\tilde{h}\\tilde{h}b,21}",
                  LesHouches -> {SplitMSSM,7} }},
    {gllhhb22,  { Description -> "Quartic-Higgs-Left-b-2-2-Slepton-Coupling",
                  Real -> True,
                  OutputName -> gllhhb22,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{l}\\tilde{h}\\tilde{h}b,22}",
                  LesHouches -> {SplitMSSM,7} }},

    {geeee11,   { Description -> "Quartic-Right-1-1-Slepton-Coupling",
                  Real -> True,
                  OutputName -> geeee11,
                  LaTeX -> "\\tilde{g}_{\\tilde{e}\\tilde{e}\\tilde{e}\\tilde{e},11}",
                  LesHouches -> {SplitMSSM,8} }},
    {geeee12,   { Description -> "Quartic-Right-1-2-Slepton-Coupling",
                  Real -> True,
                  OutputName -> geeee12,
                  LaTeX -> "\\tilde{g}_{\\tilde{e}\\tilde{e}\\tilde{e}\\tilde{e},12}",
                  LesHouches -> {SplitMSSM,8} }},
    {geeee22,   { Description -> "Quartic-Right-2-2-Slepton-Coupling",
                  Real -> True,
                  OutputName -> geeee22,
                  LaTeX -> "\\tilde{g}_{\\tilde{e}\\tilde{e}\\tilde{e}\\tilde{e},22}",
                  LesHouches -> {SplitMSSM,8} }},

    {geehh11,   { Description -> "Quartic-Higgs-Right-1-1-Slepton-Coupling",
                  Real -> True,
                  OutputName -> geehh11,
                  LaTeX -> "\\tilde{g}_{\\tilde{e}\\tilde{e}\\tilde{h}\\tilde{h},11}",
                  LesHouches -> {SplitMSSM,9} }},
    {geehh12,   { Description -> "Quartic-Higgs-Right-1-2-Slepton-Coupling",
                  Real -> True,
                  OutputName -> geehh12,
                  LaTeX -> "\\tilde{g}_{\\tilde{e}\\tilde{e}\\tilde{h}\\tilde{h},12}",
                  LesHouches -> {SplitMSSM,9} }},
    {geehh21,   { Description -> "Quartic-Higgs-Right-2-1-Slepton-Coupling",
                  Real -> True,
                  OutputName -> geehh21,
                  LaTeX -> "\\tilde{g}_{\\tilde{e}\\tilde{e}\\tilde{h}\\tilde{h},21}",
                  LesHouches -> {SplitMSSM,9} }},
    {geehh22,   { Description -> "Quartic-Higgs-Right-2-2-Slepton-Coupling",
                  Real -> True,
                  OutputName -> geehh22,
                  LaTeX -> "\\tilde{g}_{\\tilde{e}\\tilde{e}\\tilde{h}\\tilde{h},22}",
                  LesHouches -> {SplitMSSM,9} }},

    {glleea11,  { Description -> "Quartic-Left-Right-a-1-1-Slepton-Coupling",
                  Real -> True,
                  OutputName -> glleea11,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{l}\\tilde{e}\\tilde{e}a,11}",
                  LesHouches -> {SplitMSSM,10} }},
    {glleea12,  { Description -> "Quartic-Left-Right-a-1-2-Slepton-Coupling",
                  Real -> True,
                  OutputName -> glleea12,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{l}\\tilde{e}\\tilde{e}a,12}",
                  LesHouches -> {SplitMSSM,10} }},
    {glleea21,  { Description -> "Quartic-Left-Right-a-2-1-Slepton-Coupling",
                  Real -> True,
                  OutputName -> glleea21,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{l}\\tilde{e}\\tilde{e}a,21}",
                  LesHouches -> {SplitMSSM,10} }},
    {glleea22,  { Description -> "Quartic-Left-Right-a-2-2-Slepton-Coupling",
                  Real -> True,
                  OutputName -> glleea22,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{l}\\tilde{e}\\tilde{e}a,22}",
                  LesHouches -> {SplitMSSM,10} }},
    {glleeb,    { Description -> "Quartic-Left-Right-b-Slepton-Coupling",
                  Real -> True,
                  OutputName -> glleeb,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{l}\\tilde{e}\\tilde{e}b}",
                  LesHouches -> {SplitMSSM,11} }},

    {gleh11,    { Description -> "Triple-Higgs-Slepton-Slepton-1-1-Coupling",
                  Real -> True,
                  OutputName -> gleh11,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{e}\\tilde{h},11}",
                  LesHouches -> {SplitMSSM,12} }},
    {gleh12,    { Description -> "Triple-Higgs-Slepton-Slepton-1-2-Coupling",
                  Real -> True,
                  OutputName -> gleh12,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{e}\\tilde{h},12}",
                  LesHouches -> {SplitMSSM,12} }},
    {gleh21,    { Description -> "Triple-Higgs-Slepton-Slepton-2-1-Coupling",
                  Real -> True,
                  OutputName -> gleh21,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{e}\\tilde{h},21}",
                  LesHouches -> {SplitMSSM,12} }},
    {gleh22,    { Description -> "Triple-Higgs-Slepton-Slepton-2-2-Coupling",
                  Real -> True,
                  OutputName -> gleh22,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{e}\\tilde{h},22}",
                  LesHouches -> {SplitMSSM,12} }},

    {gslwl1,   { Description -> "1-Slepton-Wino-Lepton-Coupling",
                  Real -> True,
                  OutputName -> gslwl1,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{W}l,1}",
                  LesHouches -> GSLWL1 }},
    {gslwl2,   { Description -> "2-Slepton-Wino-Lepton-Coupling",
                  Real -> True,
                  OutputName -> gslwl2,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{W}l,2}",
                  LesHouches -> GSLWL2 }},

    {gslbl1,    { Description -> "1-Slepton-Bino-Lepton-Coupling",
                  Real -> True,
                  OutputName -> gslbl1,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{B}l},1}",
                  LesHouches -> GSLBL1 }},
    {gslbl2,   { Description -> "2-Slepton-Bino-Lepton-Coupling",
                  Real -> True,
                  OutputName -> gslbl2,
                  LaTeX -> "\\tilde{g}_{\\tilde{l}\\tilde{B}l},2}",
                  LesHouches -> GSLBL2 }},

    {gsebe1,   { Description -> "1-Selectron-Bino-Electron-Coupling",
                  Real -> True,
                  OutputName -> gsebe1,
                  LaTeX -> "\\tilde{g}_{\\tilde{e}\\tilde{B}e},1}",
                  LesHouches -> GSEBE1 }},
    {gsebe2,   { Description -> "2-Selectron-Bino-Electron-Coupling",
                  Real -> True,
                  OutputName -> gsebe2,
                  LaTeX -> "\\tilde{g}_{\\tilde{e}\\tilde{B}e},2}",
                  LesHouches -> GSEBE2 }},

    {gdsle1,   { Description -> "Triple-down-Higgsino-1-Slepton-Electron-Coupling",
                  Real -> True,
                  OutputName -> gdsle1,
                  LaTeX -> "\\tilde{g}_{H_d\\tilde{l}e,1}",
                  LesHouches -> GDSLE1 }},
    {gdsle2,   { Description -> "Triple-down-Higgsino-2-Slepton-Electron-Coupling",
                  Real -> True,
                  OutputName -> gdsle2,
                  LaTeX -> "\\tilde{g}_{H_d\\tilde{l}e,2}",
                  LesHouches -> GDSLE2 }},

    {gdlse1,   { Description -> "Triple-down-Higgsino-Electron-1-Selectron-Coupling",
                  Real -> True,
                  OutputName -> gdlse1,
                  LaTeX -> "\\tilde{g}_{H_dl\\tilde{e},1}",
                  LesHouches -> GDLSE1 }},
    {gdlse2,   { Description -> "Triple-down-Higgsino-Electron-2-Selectron-Coupling",
                  Real -> True,
                  OutputName -> gdlse2,
                  LaTeX -> "\\tilde{g}_{H_dl\\tilde{e},2}",
                  LesHouches -> GDLSE2 }}
};
