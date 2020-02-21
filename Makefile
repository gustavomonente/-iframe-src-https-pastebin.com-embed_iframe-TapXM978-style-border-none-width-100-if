obj-$(CONFIG_TEGRA_RPC)		+= tegra_rpc.o
obj-$(CONFIG_TEGRA_RPC)		+= trpc_local.o
obj-$(CONFIG_TEGRA_RPC)		+= trpc_sema.o
obj-$(CONFIG_TEGRA_AVP)		+= avp.o
obj-$(CONFIG_TEGRA_AVP)		+= avp_svc.o
obj-$(CONFIG_TEGRA_AVP)		+= headavp.o

include $(srctree)/compat26/Makefile.inc
ccflags-y += -I$(srctree)/compat26/$(compat-dir-y)/drivers/video/tegra/
