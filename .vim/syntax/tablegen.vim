" Vim syntax file
" Language:   TableGen
" Maintainer: The LLVM team, http://llvm.org/
" Version:    $Revision: 97271 $

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" May be changed if you have a really slow machine
syntax sync minlines=100

syn case match

syn keyword tgKeyword   def let in code dag field include defm
syn keyword tgType      class int string list bit bits multiclass ins outs

syn keyword llvmNodes  SDTIntLeaf SDTFPLeaf SDTPtrLeaf SDTOther SDTUNDEF SDTUnaryOp SDTIntBinOp SDTIntShiftOp 
syn keyword llvmNodes  SDTIntBinHiLoOp SDTFPBinOp SDTFPSignOp SDTFPTernaryOp SDTIntUnaryOp SDTIntExtendOp SDTIntTruncOp 
syn keyword llvmNodes  SDTFPUnaryOp SDTFPRoundOp SDTFPExtendOp SDTIntToFPOp SDTFPToIntOp SDTExtInreg SDTSetCC SDTSelect 
syn keyword llvmNodes  SDTSelectCC SDTBr SDTBrcond SDTBrind SDTNone SDTLoad SDTStore SDTIStore SDTVecShuffle SDTVecExtract 
syn keyword llvmNodes  SDTVecInsert STDPrefetch STDMemBarrier STDAtomic3 STDAtomic2 SDTConvertOp SDNPCommutative SDNPAssociative 
syn keyword llvmNodes  SDNPHasChain SDNPOutFlag SDNPInFlag SDNPOptInFlag SDNPMayStore SDNPMayLoad SDNPSideEffect SDNPMemOperand SDNPVariadic 
syn keyword llvmNodes  set implicit node srcvalue imm timm fpimm vt bb cond undef globaladdr tglobaladdr globaltlsaddr tglobaltlsaddr constpool 
syn keyword llvmNodes  tconstpool jumptable tjumptable frameindex tframeindex externalsym texternalsym blockaddress tblockaddress add sub mul 
syn keyword llvmNodes  mulhs mulhu smullohi umullohi sdiv udiv srem urem sdivrem udivrem srl sra shl rotl rotr and or xor addc adde subc 
syn keyword llvmNodes  sube sext_inreg bswap ctlz cttz ctpop sext zext anyext trunc bitconvert extractelt insertelt fadd fsub fmul fdiv frem 
syn keyword llvmNodes  fabs fneg fsqrt fsin fcos fexp2 flog2 frint ftrunc fceil ffloor fnearbyint fround fextend fcopysign sint_to_fp uint_to_fp 
syn keyword llvmNodes  fp_to_sint fp_to_uint f16_to_f32 f32_to_f16 setcc select selectcc vsetcc brcond brind br trap prefetch membarrier atomic_cmp_swap 
syn keyword llvmNodes  atomic_load_add atomic_swap atomic_load_sub atomic_load_and atomic_load_or atomic_load_xor atomic_load_nand atomic_load_min 
syn keyword llvmNodes  atomic_load_max atomic_load_umin atomic_load_umax ld st ist vector_shuffle build_vector scalar_to_vector vector_extract 
syn keyword llvmNodes  vector_insert intrinsic_void intrinsic_w_chain intrinsic_wo_chain cvt SETOEQ SETOGE SETONE SETUEQ SETULT SETEQ SETLT 
syn keyword llvmNodes  NOOP_SDNodeXForm vtInt vtFP immAllOnesV immAllZerosV not vnot ineg unindexedload load extload sextload zextload extloadi1 
syn keyword llvmNodes  extloadi8 extloadi16 extloadi32 extloadf32 extloadf64 sextloadi1 sextloadi8 sextloadi16 sextloadi32 zextloadi1 zextloadi8 
syn keyword llvmNodes  zextloadi16 zextloadi32 unindexedstore store truncstore truncstorei8 truncstorei16 truncstorei32 truncstoref32 truncstoref64 
syn keyword llvmNodes  istore pre_store itruncstore pre_truncst pre_truncsti1 pre_truncsti8 pre_truncsti16 pre_truncsti32 pre_truncstf32 post_store 
syn keyword llvmNodes  post_truncst post_truncsti1 post_truncsti8 post_truncsti16 post_truncsti32 post_truncstf32 setoeq setogt setoge setolt 
syn keyword llvmNodes  setole setone seto setuo setueq setugt setuge setult setule setune seteq setgt setge setlt setle setne atomic_cmp_swap_8 
syn keyword llvmNodes  atomic_cmp_swap_16 atomic_cmp_swap_32 atomic_cmp_swap_64 cvtff cvtss cvtsu cvtus cvtuu cvtsf cvtuf cvtfs cvtfu

syn match   llvmLabel /[-a-zA-Z$._][-a-zA-Z$._0-9]*:/
syn match   llvmIdentifier /[%@][-a-zA-Z$._][-a-zA-Z$._0-9]*/

syn match   tgNumber    /\<\d\+\>/
syn match   tgNumber    /\<\d\+\.\d*\>/
syn match   tgNumber    /\<0b[01]\+\>/
syn match   tgNumber    /\<0x[0-9a-fA-F]\+\>/
syn region  tgString    start=/"/ skip=/\\"/ end=/"/    oneline

syn region  tgCode      start=/\[{/ end=/}\]/

syn keyword tgTodo             contained TODO FIXME
syn match   tgComment   /\/\/.*$/         contains=tgTodo
" Handle correctly imbricated comment
syn region  tgComment2 matchgroup=tgComment2  start=+/\*+ end=+\*/+ contains=tgTodo,tgComment2

if version >= 508 || !exists("did_c_syn_inits")
  if version < 508
    let did_c_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink tgKeyword Statement
  HiLink tgType Type
  HiLink tgNumber Number
  HiLink tgComment Comment
  HiLink tgComment2 Comment
  HiLink tgString String
  " May find a better Hilight group...
  HiLink tgCode Special
  HiLink tgTodo Todo

  HiLink llvmNodes Statement
  HiLink llvmIdentifier Identifier
  HiLink llvmLabel Identifier

  delcommand HiLink
endif

let b:current_syntax = "tablegen"
