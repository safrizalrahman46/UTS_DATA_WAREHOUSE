/*
 Navicat Premium Data Transfer

 Source Server         : MySql
 Source Server Type    : MySQL
 Source Server Version : 80030
 Source Host           : localhost:3306
 Source Schema         : toko_barokah

 Target Server Type    : MySQL
 Target Server Version : 80030
 File Encoding         : 65001

 Date: 26/04/2025 10:21:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for detail_transaksi
-- ----------------------------
DROP TABLE IF EXISTS `detail_transaksi`;
CREATE TABLE `detail_transaksi`  (
  `kode_transaksi` int(0) NOT NULL AUTO_INCREMENT,
  `fk_id_produk` int(0) NULL DEFAULT NULL,
  `fk_nomor_transaksi` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `qty` double NULL DEFAULT NULL,
  PRIMARY KEY (`kode_transaksi`) USING BTREE,
  INDEX `fk_nomor_transaksi`(`fk_nomor_transaksi`) USING BTREE,
  INDEX `fk_id_produk`(`fk_id_produk`) USING BTREE,
  CONSTRAINT `detail_transaksi_ibfk_1` FOREIGN KEY (`fk_nomor_transaksi`) REFERENCES `transaksi` (`nomor_transaksi`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `detail_transaksi_ibfk_2` FOREIGN KEY (`fk_id_produk`) REFERENCES `produk` (`id_produk`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13070 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dim_customer
-- ----------------------------
DROP TABLE IF EXISTS `dim_customer`;
CREATE TABLE `dim_customer`  (
  `id_member` int(0) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_member`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dim_produk
-- ----------------------------
DROP TABLE IF EXISTS `dim_produk`;
CREATE TABLE `dim_produk`  (
  `id_produk` int(0) NOT NULL AUTO_INCREMENT,
  `nama_produk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `harga` decimal(10, 2) NULL DEFAULT NULL,
  `satuan` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_produk`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dim_waktu
-- ----------------------------
DROP TABLE IF EXISTS `dim_waktu`;
CREATE TABLE `dim_waktu`  (
  `id_waktu` int(0) NOT NULL AUTO_INCREMENT,
  `tanggal` date NULL DEFAULT NULL,
  `hari` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `minggu` int(0) NULL DEFAULT NULL,
  `bulan` int(0) NULL DEFAULT NULL,
  `nama_bulan` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kuartal` int(0) NULL DEFAULT NULL,
  `tahun` int(0) NULL DEFAULT NULL,
  `hari_kerja` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id_waktu`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for fact_penjualan
-- ----------------------------
DROP TABLE IF EXISTS `fact_penjualan`;
CREATE TABLE `fact_penjualan`  (
  `id_penjualan` int(0) NOT NULL AUTO_INCREMENT,
  `id_waktu` int(0) NULL DEFAULT NULL,
  `id_produk` int(0) NULL DEFAULT NULL,
  `id_member` int(0) NULL DEFAULT NULL,
  `nomor_transaksi` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `qty` decimal(10, 2) NULL DEFAULT NULL,
  `total_harga` decimal(12, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_penjualan`) USING BTREE,
  INDEX `id_waktu`(`id_waktu`) USING BTREE,
  INDEX `id_produk`(`id_produk`) USING BTREE,
  INDEX `id_customer`(`id_member`) USING BTREE,
  CONSTRAINT `fact_penjualan_ibfk_1` FOREIGN KEY (`id_waktu`) REFERENCES `dim_waktu` (`id_waktu`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fact_penjualan_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `dim_produk` (`id_produk`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pembeli
-- ----------------------------
DROP TABLE IF EXISTS `pembeli`;
CREATE TABLE `pembeli`  (
  `id_member` int(0) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_member`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for penjual
-- ----------------------------
DROP TABLE IF EXISTS `penjual`;
CREATE TABLE `penjual`  (
  `id_penjual` int(0) NOT NULL AUTO_INCREMENT,
  `nama_penjual` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_penjual`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for produk
-- ----------------------------
DROP TABLE IF EXISTS `produk`;
CREATE TABLE `produk`  (
  `id_produk` int(0) NOT NULL AUTO_INCREMENT,
  `nama_produk` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `satuan` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `harga` double NULL DEFAULT NULL,
  PRIMARY KEY (`id_produk`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 682 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for transaksi
-- ----------------------------
DROP TABLE IF EXISTS `transaksi`;
CREATE TABLE `transaksi`  (
  `nomor_transaksi` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fk_id_penjual` int(0) NULL DEFAULT NULL,
  `fk_id_pembeli` int(0) NULL DEFAULT NULL,
  `tanggal` date NULL DEFAULT NULL,
  PRIMARY KEY (`nomor_transaksi`) USING BTREE,
  INDEX `fk_id_penjual`(`fk_id_penjual`) USING BTREE,
  INDEX `fk_id_pembeli`(`fk_id_pembeli`) USING BTREE,
  CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`fk_id_penjual`) REFERENCES `penjual` (`id_penjual`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`fk_id_pembeli`) REFERENCES `pembeli` (`id_member`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
