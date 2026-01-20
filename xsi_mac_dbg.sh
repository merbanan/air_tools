reg_c1()                               
{
  NAME=$1
  BASE=$2
  OFF=$3

  V1=$(($BASE | $OFF))
  RES=$(devmem $V1)
  printf "%-30s  = %-10s, " $NAME $RES

}

reg_c2()

  NAME=$1
  BASE=$2
  OFF=$3

  V1=$(($BASE | $OFF))
  RES=$(devmem $V1)
  printf "%-30s    = %-10s\n" $NAME $RES 
}

seg_c1()
{
  NAME=$1
  BASE=$2
  OFF=$3
  SHIFT=$4

  V1=$(($BASE | $OFF))
  RES=$(devmem $V1)
  RES_S=$(($RES >> $SHIFT))
  RES_M=$(($RES_S & 0xFFFF))

  printf "%-30s  = 0x%08X, " $NAME $RES_M

}
seg_c2()
{
  NAME=$1
  BASE=$2
  OFF=$3
  SHIFT=$4

  V1=$(($BASE | $OFF))
  RES=$(devmem $V1)
  RES_S=$(($RES >> $SHIFT))
  RES_M=$(($RES_S & 0xFFFF))
  printf "%-30s    = 0x%08X\n" $NAME $RES_M
}

xsi_dbg()
{
  NAME=$1
  BASE=$2

  echo "XSI MAC debug cnt: $NAME"

  reg_c1 TX_OCTETS_CNT $BASE 0x104
  reg_c2 TX_PKT_CNT $BASE 0x108
  reg_c1 TXMBI_ETH_CNT $BASE 0x114
  reg_c2 TXMBI_UCETH_CNT $BASE 0x118
  seg_c1 TXMBI_MCETH_CNT $BASE 0x11C 0
  seg_c2 TXMBI_BCETH_CNT $BASE 0x11C 16
  seg_c1 TXMBI_PAUSEON_CNT $BASE 0x120 0
  seg_c2 TXMBI_PAUSEOFF_CNT $BASE 0x120 16
  reg_c1 TX_BYTES_CNT $BASE 0x134
  reg_c2 TX_NORMAL_PKT_BYTES_CNT $BASE 0x138

  reg_c1 RX_FRAME_CNT $BASE 0x180
  reg_c2 RX_OCTETS_CNT $BASE 0x184 
  reg_c1 RX_PKT_CNT $BASE 0x188
  reg_c2 RX_ETH_CNT $BASE 0x18C
  seg_c1 RX_PAUSEON_CNT $BASE 0x190 0
  seg_c2 RX_PAUSEOFF_CNT $BASE 0x190 16
  seg_c1 RX_LENERR_CNT $BASE 0x194 0
  seg_c2 RX_FRAGERR_CNT $BASE 0x194 16
  seg_c1 RX_CRCERR_CNT $BASE 0x198 0 
  seg_c2 RX_CODINGERR_CNT $BASE 0x198 16
  reg_c1 RXMBI_ETH_CNT $BASE 0x19C  
  seg_c2 RXMBI_ERRDROP_CNT $BASE 0x1A0 0
  seg_c1 RXMBI_SOFDROP_CNT $BASE 0x1A0 16
  seg_c2 RX_SOF_CNT $BASE 0x1A4 0
  seg_c1 RX_EOF_CNT $BASE 0x1A4 16
  seg_c2 RX_MPI_SOP_CNT $BASE 0x1A8 0
  seg_c1 RX_MPI_SOP_CNT $BASE 0x1A8 16
  reg_c2 RX_NORMAL_PKT_BYTES_CNT $BASE 0x1AC
  seg_c1 RX_MBI_SOP_CNT $BASE 0x1B8 0
  seg_c2 RX_MBI_EOP $BASE 0x1B8 16
  reg_c1 RX_UC_DROP_CNT $BASE 0x200
  reg_c2 RX_BC_DROP_CNT $BASE 0x204
  reg_c1 RX_MC_DROP_CNT $BASE 0x208
  reg_c2 RX_TOTAL_DROP_CNT $BASE 0x20C
}

xsi_dbg ae 0x1fa60000
#xsi_dbg pcie0 0x1fa70000
#xsi_dbg pcie1 0x1fa71000
xsi_dbg usb3 0x1fa80000
