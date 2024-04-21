# Wake On Lan Cisco Wake Up Script 

The TCL script which is attached can be used to force Wake on Lan activity for specified hosts on a segment. 

Using the Kron routine listed below, a regular wake up cycle can be configured on a per switch basis. 

### Example Routine Configured on Cisco Switch
```rust
kron occurrence WakeUp in 1 recurring
policy-list WakeUp
kron policy-list WakeUp
cli tclsh tftp://10.0.0.11/WakeUp.tcl 255.255.255.255 00:0c:29:14:be:35 Enterprise
```

Whilst TFTP is shown in the below example, other more secure methods to launch the TCL script, can be used.