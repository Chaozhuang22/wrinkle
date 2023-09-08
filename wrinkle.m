function out = model
%
% wrinkle.m
%
% Model exported on Sep 8 2023, 15:10 by COMSOL 6.1.0.282.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('F:\1_COMSOL Base\4.Wrinkle');

model.label('74. 2D final.mph');

model.param.set('length', '2[um]', 'Length of the block');
model.param.set('height', '0.6[um]', 'Height of the block');
model.param.set('tf', '10[nm]', 'Thickness of thin layer');
model.param.set('Sr', '100', 'Stiffness ratio');
model.param.set('imp', '0.05', 'Imperfection amplitude');
model.param.set('mesh', '50', 'Mesh density along x direction');
model.param.set('compStrain', '0.1', 'Compressive strain');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 2);

model.result.table.create('evl3', 'Table');

model.component('comp1').mesh.create('mesh1');

model.component('comp1').geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.component('comp1').geom('geom1').create('r1', 'Rectangle');
model.component('comp1').geom('geom1').feature('r1').set('size', {'length' 'height'});
model.component('comp1').geom('geom1').create('pc1', 'ParametricCurve');
model.component('comp1').geom('geom1').feature('pc1').set('pos', {'0' 'height-tf*1.1'});
model.component('comp1').geom('geom1').feature('pc1').set('parmax', 'length');
model.component('comp1').geom('geom1').feature('pc1').set('coord', {'s' 'imp*tf*sin(pi*s/(length/1[um]))'});
model.component('comp1').geom('geom1').create('mov1', 'Move');
model.component('comp1').geom('geom1').feature('mov1').set('keep', true);
model.component('comp1').geom('geom1').feature('mov1').set('disply', '-tf');
model.component('comp1').geom('geom1').feature('mov1').selection('input').set({'pc1'});
model.component('comp1').geom('geom1').create('pard1', 'PartitionDomains');
model.component('comp1').geom('geom1').feature('pard1').set('partitionwith', 'edges');
model.component('comp1').geom('geom1').feature('pard1').selection('domain').set('r1(1)', 1);
model.component('comp1').geom('geom1').feature('pard1').selection('edge').set('pc1(1)', 1);
model.component('comp1').geom('geom1').feature('pard1').selection('edge').set('mov1(1)', 1);
model.component('comp1').geom('geom1').create('del1', 'Delete');
model.component('comp1').geom('geom1').feature('del1').selection('input').init(2);
model.component('comp1').geom('geom1').feature('del1').selection('input').set('pard1(1)', 3);
model.component('comp1').geom('geom1').run;
model.component('comp1').geom('geom1').run('fin');

model.component('comp1').variable.create('var1');
model.component('comp1').variable('var1').set('ampvar', 'maxop1(v)-minop1(v)');

model.view.create('view2', 3);

model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material.create('mat2', 'Common');
model.component('comp1').material('mat1').selection.set([1]);
model.component('comp1').material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.component('comp1').material('mat2').selection.set([2]);
model.component('comp1').material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');

model.component('comp1').cpl.create('maxop1', 'Maximum');
model.component('comp1').cpl.create('minop1', 'Minimum');
model.component('comp1').cpl.create('aveop1', 'Average');
model.component('comp1').cpl('maxop1').selection.geom('geom1', 1);
model.component('comp1').cpl('maxop1').selection.set([7]);
model.component('comp1').cpl('minop1').selection.geom('geom1', 1);
model.component('comp1').cpl('minop1').selection.set([6]);
model.component('comp1').cpl('aveop1').selection.geom('geom1', 1);
model.component('comp1').cpl('aveop1').selection.set([7]);

model.component('comp1').physics.create('plate', 'Plate', 'geom1');
model.component('comp1').physics('plate').create('ssp1', 'SimplySupported', 1);
model.component('comp1').physics('plate').feature('ssp1').selection.set([2]);
model.component('comp1').physics('plate').create('sym1', 'SymmetrySolid1', 1);
model.component('comp1').physics('plate').feature('sym1').selection.set([1 3]);
model.component('comp1').physics('plate').create('disp1', 'Displacement1', 1);
model.component('comp1').physics('plate').feature('disp1').selection.set([4 5]);

model.component('comp1').mesh('mesh1').create('map1', 'Map');
model.component('comp1').mesh('mesh1').create('map2', 'Map');
model.component('comp1').mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.component('comp1').mesh('mesh1').feature('map1').selection.set([2]);
model.component('comp1').mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.component('comp1').mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.component('comp1').mesh('mesh1').feature('map1').feature('dis1').selection.set([3]);
model.component('comp1').mesh('mesh1').feature('map1').feature('dis2').selection.set([7]);
model.component('comp1').mesh('mesh1').feature('map2').create('dis1', 'Distribution');
model.component('comp1').mesh('mesh1').feature('map2').feature('dis1').selection.set([1 4]);

model.result.table('evl3').label('Evaluation 3D');
model.result.table('evl3').comments('Interactive 3D values');

model.component('comp1').view('view1').axis.set('xmin', 1.7843736410140991);
model.component('comp1').view('view1').axis.set('xmax', 2.0701801776885986);
model.component('comp1').view('view1').axis.set('ymin', 0.4800125062465668);
model.component('comp1').view('view1').axis.set('ymax', 0.6734509468078613);
model.view('view2').set('showgrid', false);
model.view('view2').set('showaxisorientation', false);

model.component('comp1').material('mat1').label('Soft layer');
model.component('comp1').material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'9e-4[1/K]' '0' '0' '0' '9e-4[1/K]' '0' '0' '0' '9e-4[1/K]'});
model.component('comp1').material('mat1').propertyGroup('def').set('heatcapacity', '1460[J/(kg*K)]');
model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {'2.75' '0' '0' '0' '2.75' '0' '0' '0' '2.75'});
model.component('comp1').material('mat1').propertyGroup('def').set('density', '970[kg/m^3]');
model.component('comp1').material('mat1').propertyGroup('def').set('thermalconductivity', {'0.16[W/(m*K)]' '0' '0' '0' '0.16[W/(m*K)]' '0' '0' '0' '0.16[W/(m*K)]'});
model.component('comp1').material('mat1').propertyGroup('Enu').set('E', '1[MPa]');
model.component('comp1').material('mat1').propertyGroup('Enu').set('nu', '0.25');
model.component('comp1').material('mat2').label('Stiff layer');
model.component('comp1').material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'9e-4[1/K]' '0' '0' '0' '9e-4[1/K]' '0' '0' '0' '9e-4[1/K]'});
model.component('comp1').material('mat2').propertyGroup('def').set('heatcapacity', '1460[J/(kg*K)]');
model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', {'2.75' '0' '0' '0' '2.75' '0' '0' '0' '2.75'});
model.component('comp1').material('mat2').propertyGroup('def').set('density', '970[kg/m^3]');
model.component('comp1').material('mat2').propertyGroup('def').set('thermalconductivity', {'0.16[W/(m*K)]' '0' '0' '0' '0.16[W/(m*K)]' '0' '0' '0' '0.16[W/(m*K)]'});
model.component('comp1').material('mat2').propertyGroup('Enu').set('E', 'Sr*1[MPa]');
model.component('comp1').material('mat2').propertyGroup('Enu').set('nu', '0.25');

model.component('comp1').physics('plate').prop('StructuralTransientBehavior').set('StructuralTransientBehavior', 'Quasistatic');
model.component('comp1').physics('plate').feature('dcont1').set('pairDisconnect', true);
model.component('comp1').physics('plate').feature('dcont1').label('Continuity');
model.component('comp1').physics('plate').feature('ssp1').set('AlongEdge', false);
model.component('comp1').physics('plate').feature('disp1').set('U0', {'-compStrain*length'; '0'; '0'});
model.component('comp1').physics('plate').feature('disp1').set('Direction', [1; 0; 0]);

model.component('comp1').mesh('mesh1').feature('map1').feature('dis1').set('numelem', 3);
model.component('comp1').mesh('mesh1').feature('map1').feature('dis2').set('numelem', 'mesh');
model.component('comp1').mesh('mesh1').feature('map2').feature('dis1').set('type', 'predefined');
model.component('comp1').mesh('mesh1').feature('map2').feature('dis1').set('elemcount', 'mesh*0.2');
model.component('comp1').mesh('mesh1').feature('map2').feature('dis1').set('elemratio', 0.02);
model.component('comp1').mesh('mesh1').feature('map2').feature('dis1').set('growthrate', 'exponential');
model.component('comp1').mesh('mesh1').run;

model.study.create('std1');
model.study('std1').create('param', 'Parametric');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('geometricNonlinearity', true);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature.remove('fcDef');

model.result.dataset.create('emb1', 'Embed2D');
model.result.create('pg1', 'PlotGroup3D');
model.result.create('pg2', 'PlotGroup1D');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'plate.mises');
model.result('pg1').feature('surf1').create('def1', 'Deform');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').selection.set([6]);
model.result('pg2').feature('lngr1').set('expr', 'v');
model.result('pg3').create('glob1', 'Global');
model.result.export.create('anim1', 'Animation');

model.study('std1').feature('param').set('sweeptype', 'filled');
model.study('std1').feature('param').set('pname', {'compStrain'});
model.study('std1').feature('param').set('plistarr', {'range(0,0.0025,0.025), range(0.026,0.0001,0.032)'});
model.study('std1').feature('param').set('punit', {''});
model.study('std1').feature('param').set('plot', true);
model.study('std1').feature('param').set('plotgroup', 'pg3');
model.study('std1').feature('param').set('reusesol', true);

model.sol('sol1').attach('std1');
model.sol('sol1').feature('st1').label('Compile Equations: Stationary');
model.sol('sol1').feature('v1').label('Dependent Variables 1.1');
model.sol('sol1').feature('v1').set('clistctrl', {'p1'});
model.sol('sol1').feature('v1').set('cname', {'compStrain'});
model.sol('sol1').feature('v1').set('clist', {'range(0,0.0025,0.025) range(0.026,0.0001,0.032)'});
model.sol('sol1').feature('v1').feature('comp1_ar').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_ar').set('scaleval', 0.01);
model.sol('sol1').feature('s1').label('Stationary Solver 1.1');
model.sol('sol1').feature('s1').set('probesel', 'none');
model.sol('sol1').feature('s1').feature('dDef').label('Direct 1');
model.sol('sol1').feature('s1').feature('aDef').label('Advanced 1');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').feature('p1').label('Parametric 1.1');
model.sol('sol1').feature('s1').feature('p1').set('control', 'param');
model.sol('sol1').feature('s1').feature('p1').set('sweeptype', 'filled');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'compStrain'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'range(0,0.0025,0.025), range(0.026,0.0001,0.032)'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {''});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'yes');
model.sol('sol1').feature('s1').feature('p1').set('plot', true);
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'pg3');
model.sol('sol1').feature('s1').feature('fc1').label('Fully Coupled 1.1');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').runAll;

model.result('pg1').label('Disp');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'von Mises stress');
model.result('pg1').set('edges', false);
model.result('pg1').set('showlegends', false);
model.result('pg1').feature('surf1').set('const', {'plate.refpntx' '0' 'Reference point for moment computation, x coordinate';  ...
'plate.refpnty' '0' 'Reference point for moment computation, y coordinate';  ...
'plate.refpntz' '0' 'Reference point for moment computation, z coordinate';  ...
'plate.z' '1' 'Local z-coordinate [-1,1] for thickness-dependent results'});
model.result('pg1').feature('surf1').set('colortable', 'RainbowClassic');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg1').feature('surf1').feature('def1').set('scale', 5);
model.result('pg1').feature('surf1').feature('def1').set('scaleactive', true);
model.result('pg2').label('Cross section');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Surface profile of the bilayer');
model.result('pg2').set('xlabel', ['Arc length (' native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm)']);
model.result('pg2').set('ylabel', 'Displacement field (nm)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('xlabelactive', false);
model.result('pg2').feature('lngr1').set('unit', 'nm');
model.result('pg2').feature('lngr1').set('descr', 'Displacement field, Y component');
model.result('pg2').feature('lngr1').set('const', {'plate.refpntx' '0' 'Reference point for moment computation, x coordinate';  ...
'plate.refpnty' '0' 'Reference point for moment computation, y coordinate';  ...
'plate.refpntz' '0' 'Reference point for moment computation, z coordinate';  ...
'plate.z' '1' 'Local z-coordinate [-1,1] for thickness-dependent results'});
model.result('pg2').feature('lngr1').set('resolution', 'normal');
model.result('pg3').label('Max-min');
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Wrinkle amplitude  (nm)');
model.result('pg3').set('xlabel', 'Compressive strain');
model.result('pg3').set('xlabelactive', true);
model.result('pg3').set('showlegends', false);
model.result('pg3').feature('glob1').set('expr', {'maxop1(v)-minop1(v)'});
model.result('pg3').feature('glob1').set('unit', {'nm'});
model.result('pg3').feature('glob1').set('descr', {''});
model.result('pg3').feature('glob1').set('const', {'plate.refpntx' '0' 'Reference point for moment computation, x coordinate';  ...
'plate.refpnty' '0' 'Reference point for moment computation, y coordinate';  ...
'plate.refpntz' '0' 'Reference point for moment computation, z coordinate';  ...
'plate.z' '1' 'Local z-coordinate [-1,1] for thickness-dependent results'});
model.result('pg3').feature('glob1').set('linewidth', 2);
model.result('pg3').feature('glob1').set('linewidthslider', 2);
model.result.export('anim1').set('giffilename', 'C:\Users\ZhuangChao\Chaozhuang22.github.io\assets\images\wrinkle\anime.gif');
model.result.export('anim1').set('framesel', 'all');
model.result.export('anim1').set('width', 2048);
model.result.export('anim1').set('height', 768);
model.result.export('anim1').set('zoomextents', true);
model.result.export('anim1').set('fontsize', '40');
model.result.export('anim1').set('colortheme', 'globaltheme');
model.result.export('anim1').set('customcolor', [1 1 1]);
model.result.export('anim1').set('background', 'color');
model.result.export('anim1').set('gltfincludelines', 'on');
model.result.export('anim1').set('title1d', 'on');
model.result.export('anim1').set('legend1d', 'off');
model.result.export('anim1').set('logo1d', 'off');
model.result.export('anim1').set('options1d', 'on');
model.result.export('anim1').set('title2d', 'on');
model.result.export('anim1').set('legend2d', 'on');
model.result.export('anim1').set('logo2d', 'on');
model.result.export('anim1').set('options2d', 'off');
model.result.export('anim1').set('title3d', 'on');
model.result.export('anim1').set('legend3d', 'off');
model.result.export('anim1').set('logo3d', 'off');
model.result.export('anim1').set('options3d', 'on');
model.result.export('anim1').set('axisorientation', 'off');
model.result.export('anim1').set('grid', 'off');
model.result.export('anim1').set('axes1d', 'on');
model.result.export('anim1').set('axes2d', 'on');
model.result.export('anim1').set('showgrid', 'off');

out = model;
