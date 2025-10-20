import React from 'react';
import { PALETTE } from '../../constants/Colors';

const NavBar = () =>{
    const colorPrimary = PALETTE.primary;
    const colorTextActive = PALETTE.textPrimary;
    const colorTextHover = PALETTE.accent;

    return (
        <>
        <nav className="border-gray-200" style={{ backgroundColor: colorPrimary }}>
            <div className="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
                
                <a href="/" className="flex items-center space-x-3 rtl:space-x-reverse">
                    <img src="src/assets/logo.jpg" className="h-10" alt="Logo" />
                    <span className="self-center text-2xl font-semibold whitespace-nowrap" style={{ color: colorTextActive }}>Flowbite</span>
                </a>
                
                <button data-collapse-toggle="navbar-default" type="button" className="inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-700 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-300" aria-controls="navbar-default" aria-expanded="false">
                    <span className="sr-only">Open main menu</span>
                    <svg className="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 17 14">
                        <path stroke="currentColor" strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M1 1h15M1 7h15M1 13h15"/>
                    </svg>
                </button>
                
                <div className="hidden w-full md:block md:w-auto" id="navbar-default">
                    <ul className={`font-medium flex flex-col p-4 md:p-0 mt-4 border border-gray-100 rounded-lg md:flex-row md:space-x-8 rtl:space-x-reverse md:mt-0 md:border-0 md:bg-transparent`} style={{ backgroundColor: colorPrimary }}>
                        
                        <li>
                            <a 
                                href="/" 
                                className="block py-2 px-3 rounded-sm md:bg-transparent md:p-0 font-bold"
                                style={{ color: colorTextActive }}
                                aria-current="page"
                            >
                                Home
                            </a>
                        </li>
                        
                        <li>
                            <a 
                                href="/patients" 
                                className={`block py-2 px-3 text-gray-700 rounded-sm hover:bg-gray-200 md:hover:bg-transparent md:border-0 md:p-0 
                                    md:hover:text-[${colorTextHover}] 
                                `}
                            >
                                Pacientes
                            </a>
                        </li>
                        
                        <li>
                            <a 
                                href="/products" 
                                className={`block py-2 px-3 text-gray-700 rounded-sm hover:bg-gray-200 md:hover:bg-transparent md:border-0 md:p-0 
                                    md:hover:text-[${colorTextHover}] 
                                `}
                            >
                                Producto/Servicio
                            </a>
                        </li>
                        
                        <li>
                            <a 
                                href="/config" 
                                className={`block py-2 px-3 text-gray-700 rounded-sm hover:bg-gray-200 md:hover:bg-transparent md:border-0 md:p-0 
                                    md:hover:text-[${colorTextHover}] 
                                `}
                            >
                                Configuración
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        </>
    )
}

export default NavBar;
