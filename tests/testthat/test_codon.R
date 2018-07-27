context("codon")


tree <- read.tree(text = "(((t1:.1,t2:.1):.1,t3:.2):.1,(t4:.1,t5:.1):.2);")
set.seed(42)
dat_1 <- simSeq(tree, l=1000, type = "CODON")
dat_2 <- simSeq(tree, l=1000, type = "CODON", dnds=.5)
dat_3 <- simSeq(tree, l=1000, type = "CODON", tstv=2)
dat_4 <- simSeq(tree, l=1000, type = "CODON", dnds=2, tstv=2)



fit_F1x4 <- pml(tree, dat_4, bf="F1x4")
fit_F3x4 <- pml(tree, dat_4, bf="F3x4")
fit_GY <- pml(tree, dat_4, bf="empirical")


test_that("edge length optimisation works properly", {
    skip_on_cran()
    
    fit_GY_opt <- optim.pml(fit_GY, model="codon1")
    expect_gt(fit_GY_opt$dnds, 1)
    expect_gt(fit_GY_opt$tstv, 1)
})

