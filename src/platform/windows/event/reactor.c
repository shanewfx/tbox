/*!The Treasure Box Library
 * 
 * TBox is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 2.1 of the License, or
 * (at your option) any later version.
 * 
 * TBox is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with TBox; 
 * If not, see <a href="http://www.gnu.org/licenses/"> http://www.gnu.org/licenses/</a>
 * 
 * Copyright (C) 2009 - 2011, ruki All rights reserved.
 *
 * \author		ruki
 * \file		reactor.c
 *
 */

/* /////////////////////////////////////////////////////////
 * includes
 */
#include "prefix.h"
#include "../../../event/event.h"
#include "../../../math/math.h"
#include "../../../memory/memory.h"
#include "../../../container/container.h"
#include "winsock2.h"
#include "windows.h"

// eobject
#ifdef TB_CONFIG_EVENT_HAVE_WAITO
# 	include "reactor/eobject/waito.c"
#endif

#ifdef TB_CONFIG_EVENT_HAVE_SELECT
# 	include "reactor/eobject/select.c"
#endif

// epool
#ifdef TB_CONFIG_EVENT_HAVE_WAITO
# 	include "reactor/epool/waito.c"
#endif

#ifdef TB_CONFIG_EVENT_HAVE_SELECT
# 	include "reactor/epool/select.c"
#endif

/* /////////////////////////////////////////////////////////
 * eobject
 */
#ifdef TB_CONFIG_EVENT_HAVE_WAITO

tb_long_t tb_eobject_reactor_file_wait(tb_eobject_t* object, tb_long_t timeout)
{
	return tb_eobject_reactor_waito_wait(object, timeout);
}
tb_long_t tb_eobject_reactor_evet_wait(tb_eobject_t* object, tb_long_t timeout)
{
	return tb_eobject_reactor_waito_wait(object, timeout);
}
#endif


#ifdef TB_CONFIG_EVENT_HAVE_SELECT
tb_long_t tb_eobject_reactor_sock_wait(tb_eobject_t* object, tb_long_t timeout)
{
	return tb_eobject_reactor_select_wait(object, timeout);
}

#endif

/* /////////////////////////////////////////////////////////
 * epool
 */
#ifdef TB_CONFIG_EVENT_HAVE_SELECT
tb_epool_reactor_t* tb_epool_reactor_file_init(tb_epool_t* epool)
{
	return tb_epool_reactor_waito_init(epool);
}
tb_epool_reactor_t* tb_epool_reactor_evet_init(tb_epool_t* epool)
{
	return tb_epool_reactor_waito_init(epool);
}
#endif

#ifdef TB_CONFIG_EVENT_HAVE_SELECT
tb_epool_reactor_t* tb_epool_reactor_sock_init(tb_epool_t* epool)
{
	return tb_epool_reactor_select_init(epool);
}
#endif

