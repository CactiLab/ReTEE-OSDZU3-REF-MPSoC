#include "platform.h"
#include <string.h>

extern void _MODULE_BASE;
extern void _MODULE_SIZE;

size_t module_sz = (size_t) &_MODULE_SIZE;

char ssc_module_loaded = 0;
unsigned int register_values[32]; 

void RELOAD_SSA()
{
    memset(&_MODULE_BASE, 0, module_sz);

	int z = 0;
	asm volatile ("add r0, %0, %1": :"r" (z), "r" (register_values[0]));
	asm volatile ("add r1, %0, %1": :"r" (z), "r" (register_values[1]));
	asm volatile ("add r2, %0, %1": :"r" (z), "r" (register_values[2]));
	asm volatile ("add r3, %0, %1": :"r" (z), "r" (register_values[3]));
	asm volatile ("add r4, %0, %1": :"r" (z), "r" (register_values[4]));
	asm volatile ("add r5, %0, %1": :"r" (z), "r" (register_values[5]));
	asm volatile ("add r6, %0, %1": :"r" (z), "r" (register_values[6]));
	asm volatile ("add r7, %0, %1": :"r" (z), "r" (register_values[7]));
	asm volatile ("add r8, %0, %1": :"r" (z), "r" (register_values[8]));
	asm volatile ("add r9, %0, %1": :"r" (z), "r" (register_values[9]));
	asm volatile ("add r10, %0, %1": :"r" (z), "r" (register_values[10]));
	asm volatile ("add r11, %0, %1": :"r" (z), "r" (register_values[11]));
	asm volatile ("add r12, %0, %1": :"r" (z), "r" (register_values[12]));
	asm volatile ("add r13, %0, %1": :"r" (z), "r" (register_values[13]));
    // asm volatile ("add r14, %0, %1": :"r" (z), "r" (register_values[14]));
	// asm volatile ("add r15, %0, %1": :"r" (z), "r" (register_values[15]));
	asm volatile ("add r16, %0, %1": :"r" (z), "r" (register_values[16]));
	asm volatile ("add r17, %0, %1": :"r" (z), "r" (register_values[17]));
	asm volatile ("add r18, %0, %1": :"r" (z), "r" (register_values[18]));
	asm volatile ("add r19, %0, %1": :"r" (z), "r" (register_values[19]));
	asm volatile ("add r20, %0, %1": :"r" (z), "r" (register_values[20]));
	asm volatile ("add r21, %0, %1": :"r" (z), "r" (register_values[21]));
	asm volatile ("add r22, %0, %1": :"r" (z), "r" (register_values[22]));
	asm volatile ("add r23, %0, %1": :"r" (z), "r" (register_values[23]));
	asm volatile ("add r24, %0, %1": :"r" (z), "r" (register_values[24]));
	asm volatile ("add r25, %0, %1": :"r" (z), "r" (register_values[25]));
	asm volatile ("add r26, %0, %1": :"r" (z), "r" (register_values[26]));
	asm volatile ("add r27, %0, %1": :"r" (z), "r" (register_values[27]));
	asm volatile ("add r28, %0, %1": :"r" (z), "r" (register_values[28]));
	asm volatile ("add r29, %0, %1": :"r" (z), "r" (register_values[29]));
	asm volatile ("add r30, %0, %1": :"r" (z), "r" (register_values[30]));
}
#endif

void myISR(void)
{
	InterruptProcessed = TRUE;
#ifdef KEEP_STATE
	if (c->cmd == SAVE)
		{
			register unsigned int r15 asm("r15");
			register_values[15] = r15;
			register unsigned int r1 asm("r1");
			register_values[1] = r1;
			register unsigned int r14 asm("r14");
			register_values[14] = r14;
			register unsigned int r0 asm("r0");
			register_values[0] = r0;
			register unsigned int r2 asm("r2");
			register_values[2] = r2;
			register unsigned int r3 asm("r3");
			register_values[3] = r3;
			register unsigned int r4 asm("r4");
			register_values[4] = r4;
			register unsigned int r5 asm("r5");
			register_values[5] = r5;
			register unsigned int r6 asm("r6");
			register_values[6] = r6;
			register unsigned int r7 asm("r7");
			register_values[7] = r7;
			register unsigned int r8 asm("r8");
			register_values[8] = r8;
			register unsigned int r9 asm("r9");
			register_values[9] = r9;
			register unsigned int r10 asm("r10");
			register_values[10] = r10;
			register unsigned int r11 asm("r11");
			register_values[11] = r11;
			register unsigned int r12 asm("r12");
			register_values[12] = r12;
			register unsigned int r13 asm("r13");
			register_values[13] = r13;
			register unsigned int r16 asm("r16");
			register_values[16] = r16;
			register unsigned int r17 asm("r17");
			register_values[17] = r17;
			register unsigned int r18 asm("r18");
			register_values[18] = r18;
			register unsigned int r19 asm("r19");
			register_values[19] = r19;
			register unsigned int r20 asm("r20");
			register_values[20] = r20;
			register unsigned int r21 asm("r21");
			register_values[21] = r21;
			register unsigned int r22 asm("r22");
			register_values[22] = r22;
			register unsigned int r23 asm("r23");
			register_values[23] = r23;
			register unsigned int r24 asm("r24");
			register_values[24] = r24;
			register unsigned int r25 asm("r25");
			register_values[25] = r25;
			register unsigned int r26 asm("r26");
			register_values[26] = r26;
			register unsigned int r27 asm("r27");
			register_values[27] = r27;
			register unsigned int r28 asm("r28");
			register_values[28] = r28;
			register unsigned int r29 asm("r29");
			register_values[29] = r29;
			register unsigned int r30 asm("r30");
			register_values[30] = r30;

			/*Get PC */
			asm volatile ("mfs r12, rpc;");
			register unsigned int pc asm("r12");
			register_values[31] = pc;
			memcpy((void *)c->state_chnl.registers, register_values, sizeof(unsigned int) * 32);
			set_working();
			copy_state_data();
			//main_helper();
			// int jump = 0x6b2c, z = 0;

			asm volatile ("add r14, %0, %1": :"r" (z), "r" (jump));

			set_stopped();
		}
		if (c->cmd == RELOAD)
		{
			set_working();
			int z = 0;
			RELOAD_SSA();
			set_stopped();
			asm volatile ("add r14, %0, %1": :"r" (z), "r" (register_values[14]));
			asm volatile ("add r1, %0, %1": :"r" (z), "r" (register_values[1]));
			asm volatile ("add r15, %0, %1": :"r" (z), "r" (register_values[15]));
		}
#endif
}

//////////////////////// MAIN ////////////////////////
void query_BYOT_runtime()
{
	mb_printf("BYOT_Runtime Initialized!!\r\n");
}

void load_from_shared_to_local()
{
	memcpy(local_state.code, (void *)c->code, CODE_SIZE);
}


void format_SSC_code()
{

	memcpy(local_state.code, (void *)c->code, c->file_size);
	// Invoke the attestation module
	current_att_md.ssa_size = c->file_size;
	current_att_md.cmd = 0xA;
	/*wait for HW-ATT to finish*/
	while (current_att_md.cmd != 0);


	unsigned char temp_buffer[sizeof(ssc_meta_data)];
	memset(&received_metadata, 0, sizeof(ssc_meta_data));
	memcpy(temp_buffer, local_state.code + SIG_LEN, sizeof(ssc_meta_data));

	get_unsigned_int(temp_buffer, &received_metadata);

	memcpy(ssc_data.data, (local_state.code + sizeof(ssc_meta_data) + received_metadata.sss_code_size + SIG_LEN), received_metadata.data_sec_size);
	memcpy(ssc_ro_data.ro_data, (local_state.code + sizeof(ssc_meta_data) + received_metadata.sss_code_size + received_metadata.data_sec_size + SIG_LEN), received_metadata.ro_data_size);
	memmove(local_state.code, (local_state.code + sizeof(ssc_meta_data) + SIG_LEN), received_metadata.sss_code_size);
}
void load_code()
{
	remove_ssc_module();
	mb_printf("Reading code & data modules\r\n");
	format_SSC_code();
	mb_printf("SSC Code & data loaded to BRAM\r\n");
}