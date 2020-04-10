--
-- Versão: $Id: pre_v2.3.46.sql,v 1.18 2016/01/12 12:58:34 dbrafael.nery Exp $
--
--Alterações de Layout para DIRF 2016
delete from db_sysarqcamp where codarq = 536 and codcam = 21695;
delete from db_syscampo where codcam = 21695;
delete from rhdirfgeracaopessoalregist where rh99_rhdirfgeracaodadospessoalvalor in (select rh98_sequencial from rhdirfgeracaodadospessoalvalor where rh98_rhdirftipovalor = 24);
delete from rhdirfgeracaodadospessoalvalor where rh98_rhdirftipovalor = 24;
delete from rhdirftipovalor values where rh97_sequencial = 24;
update rhdirftipovalor set rh97_descricao = 'RRA - Rendimentos isentos' where rh97_sequencial = 23;

--Alterando tamanho do campo de observações
update db_layoutcampos set db52_tamanho = 200 where db52_layoutlinha = 786 and db52_codigo = 12701;
--Alterando posição dos campos situacao_especial, data_evento e pipe
delete from db_layoutcampos where db52_layoutlinha = 781 and db52_codigo = 12751;
update db_layoutcampos set db52_posicao = 188 where db52_layoutlinha = 781 and db52_codigo = 12711;
update db_layoutcampos set db52_posicao = 189 where db52_layoutlinha = 781 and db52_codigo = 12712;
update db_layoutcampos set db52_posicao = 197 where db52_layoutlinha = 781 and db52_codigo = 12713;
--
--Excluindo layout para dirf 2016
--
delete from db_layoutcampos where db52_codigo in (12645, 12646, 12647, 12648, 12649, 12650, 12651, 12652, 12653, 12654, 12655, 12656, 12657, 12658, 12659, 12660, 12701, 12661, 12662, 12663, 12664, 12665, 12666, 12667, 12668, 12669, 12670, 12671, 12672, 12673, 12674, 12675, 12676, 12677, 12678, 12679, 12680, 12681, 12682, 12683, 12684, 12685, 12686, 12687, 12688, 12689, 12690, 12691, 12692, 12693, 12694, 12695, 12696, 12697, 12698, 12699, 12700, 12702, 12703, 12704, 12705, 12706, 12707, 12708, 12709, 12710, 12714, 12715, 12716, 12717, 12718, 12719, 12720, 12721, 12722, 12723, 12724, 12725, 12726, 12727, 12728, 12729, 12730, 12731, 12732, 12711, 12733, 12734, 12735, 12736, 12737, 12738, 12739, 12740, 12741, 12742, 12743, 12744, 12745, 12746, 12747, 12748, 12749, 12750, 12712, 12713, 12751);
delete from db_layoutlinha where db51_codigo in (775,776,777,778,779,780,781,782,783,784,785,786,787,788,789,790);
delete from db_layouttxt where db50_codigo = 230;
